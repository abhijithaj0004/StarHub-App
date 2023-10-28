import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:githubstarredapp/domain/models/github_repository_model.dart';
import 'package:http/http.dart' as http;

class GitHubRepositoryService with ChangeNotifier{
  Future<List<GitHubRepository>> fetchRepositories() async {
    final response = await http.get(
        Uri.parse('https://api.github.com/search/repositories?q=created:>2022-09-29&sort=stars&order=desc'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['items'] as List;
      List<GitHubRepository> repositories = data
          .map((repo) => GitHubRepository(
                name: repo['name'],
                description: repo['description'] ?? 'No description available',
                stars: repo['stargazers_count'],
                owner: repo['owner']['login'],
                avatarUrl: repo['owner']['avatar_url'],
              ))
          .toList();

      return repositories;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
