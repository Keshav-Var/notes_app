import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/features/presentation/pages/home_page.dart';
import 'package:notes_app/features/presentation/pages/sign_in.dart';
import 'package:notes_app/features/presentation/provider/user_provider.dart';
import 'package:notes_app/features/presentation/provider/note_provider.dart';
import 'package:notes_app/features/presentation/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => di.sl<UserProvider>(),
        ),
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => di.sl<AuthenticationProvider>()..appStarted(),
        ),
        ChangeNotifierProvider<NoteProvider>(
          create: (_) => di.sl<NoteProvider>(),
        ),
      ],
      child: MaterialApp(
        title: 'Notes app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BridgePage(),
      ),
    );
  }
}

class BridgePage extends StatelessWidget {
  const BridgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isAuthenticated) {
          return const HomePage(); // Replace with your actual home page
        } else if (!authProvider.isAuthenticated) {
          return const SignIn();
        } else {
          return const Center(
              child:
                  CircularProgressIndicator()); // Show loading indicator while checking authentication
        }
      },
    );
  }
}
