import 'package:flutter/material.dart';
import 'package:githubstarredapp/application/github_repository_service.dart';
import 'package:githubstarredapp/core/constants.dart';
import 'package:githubstarredapp/domain/models/github_repository_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<GitHubRepositoryService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Image.asset(
          'assets/images/git.png',
        ),
        title: const Text(
          'StarHub',
          style: TextStyle(fontSize: 25, letterSpacing: 2, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<GitHubRepository>>(
        future: service.fetchRepositories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final repo = snapshot.data![index];

                  return Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 219, 219)),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 231, 231, 231),
                        backgroundImage: NetworkImage(repo.avatarUrl),
                      ),
                      title: Text(repo.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(repo.description ?? 'No description available'),
                          kHeight10,
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text('${repo.stars}'),
                            ],
                          ),
                          Text(
                            'Owner: ${repo.owner}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
