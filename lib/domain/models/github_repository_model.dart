class GitHubRepository {
  final String name;
  final String? description;
  final int stars;
  final String owner;
  final String avatarUrl;

  GitHubRepository({
    required this.name,
    required this.description,
    required this.stars,
    required this.owner,
    required this.avatarUrl,
  });
}