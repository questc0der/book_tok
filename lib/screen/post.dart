import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:book_tok/providers.dart'; // assuming BookDao is provided here

class Post extends ConsumerStatefulWidget {
  const Post({super.key});

  @override
  ConsumerState createState() => _PostState();
}

class _PostState extends ConsumerState<Post> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _authorController = TextEditingController();
  final _imageLinkController = TextEditingController();
  final _categoryController = TextEditingController();
  String? selectedCategory;
  bool isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _authorController.dispose();
    _imageLinkController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookDao = ref.watch(postDaoProvider);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Title Input
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(fontFamily: 'Circular', fontSize: 18),
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 8.0),

              // Content Input
              SizedBox(
                height: 450,
                child: TextField(
                  controller: _contentController,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Write your summary here",
                    hintStyle: TextStyle(fontFamily: "Circular"),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),

              // Author Input
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(hintText: "Author"),
              ),

              // Category Label
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Choose a Category",
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              _buildCategories(),

              TextField(
                controller: _imageLinkController,
                decoration: const InputDecoration(hintText: "Image link"),
              ),

              ElevatedButton(
                onPressed: () async {
                  setState(() => isLoading = true);

                  try {
                    final account = Account(bookDao.client);
                    final user = await account.get();

                    await bookDao.post(
                      _titleController.text,
                      _contentController.text,
                      _authorController.text,
                      _imageLinkController.text,
                      user.$id,
                      user.name.isNotEmpty ? user.name : "BookTok",
                      _categoryController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Post successfully uploaded!'),
                      ),
                    );

                    // ✅ Clear all fields
                    _titleController.clear();
                    _contentController.clear();
                    _authorController.clear();
                    _imageLinkController.clear();
                    _categoryController.clear();
                  } on AppwriteException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to post: ${e.message}')),
                    );
                  } finally {
                    setState(() => isLoading = false);
                  }
                },
                child:
                    isLoading
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                        : const Text("Post"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final categories = [
      "History",
      "Adventure",
      "Comic",
      "Romance",
      "Sci-Fi",
      "Mystery",
      "Horror",
    ];

    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          return ChoiceChip(
            selected: selectedCategory == category,
            selectedColor: Colors.blue.shade300,
            label: Text(
              category,
              style: const TextStyle(fontFamily: 'Circular'),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            backgroundColor: Colors.grey.shade200,
            onSelected: (bool selected) {
              setState(() {
                selectedCategory = selected ? category : null;
                _categoryController.text = selected ? category : '';
              });
            },
          );
        },
      ),
    );
  }
}
