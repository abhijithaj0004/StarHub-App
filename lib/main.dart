import 'package:flutter/material.dart';
import 'package:githubstarredapp/application/github_repository_service.dart';
import 'package:githubstarredapp/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GitHubRepositoryService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
        ),
        home: MyHomePage(),
      ),
    );
  }
}
