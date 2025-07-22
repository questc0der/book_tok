import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen/Login/welcome.dart';
import 'package:go_router/go_router.dart';
import 'screen/home.dart';
import "./screen/Login/signup.dart";
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: App()));
}

final GoRouter _router = GoRouter(
  refreshListenable: AuthNotifier(),
  redirect: (BuildContext context, GoRouterState state) {
    final loggedIn = FirebaseAuth.instance.currentUser != null;

    // Treat both "/" (Welcome) and "/login" the same:
    final goingToAuth =
        state.matchedLocation == '/' || state.matchedLocation == '/login';

    // 1) If not logged in and not already heading to auth, send to "/"
    if (!loggedIn && !goingToAuth) return '/';

    // 2) If logged in and heading to auth ("/" or "/login"), send to "/home"
    if (loggedIn && goingToAuth) return '/home';

    // 3) Otherwise no redirect
    return null;
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const Welcome()),
    GoRoute(path: '/login', builder: (context, state) => const SignUp()),
    GoRoute(path: '/home', builder: (context, state) => Home()),
    // ...
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
