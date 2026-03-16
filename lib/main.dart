import 'package:faceid/features/posts/data/dataSource/post_apiService.dart';
import 'package:faceid/features/posts/data/respository/post_repository.dart';
import 'package:faceid/features/posts/presentation/bloc/post_bloc.dart';
import 'package:faceid/features/posts/presentation/bloc/post_event.dart';
import 'package:faceid/features/posts/presentation/screens/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) =>
          PostBloc(PostRepository(PostApiService()))..add(FetchPostsEvent()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BiometricTest(),
    );
  }
}

class BiometricTest extends StatefulWidget {
  const BiometricTest({super.key});

  @override
  State<BiometricTest> createState() => _BiometricTestState();
}

class _BiometricTestState extends State<BiometricTest> {
  final LocalAuthentication auth = LocalAuthentication();
  String message = "Not Authenticated";

  Future<void> authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Scan your biometric to continue',
      );

      setState(() {
        message = authenticated
            ? "Authentication Successful"
            : "Authentication Failed";
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PostScreen()),
      );
    } catch (e) {
      setState(() {
        message = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biometric Test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: const TextStyle(fontSize: 20)),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: authenticate,
              child: const Text("Authenticate"),
            ),
          ],
        ),
      ),
    );
  }
}
