import 'dart:convert';

import 'package:hive/hive.dart';

part 'repo_model.g.dart';

@HiveType(typeId: 0)
class RepoModel extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  bool isFavorite;

  RepoModel({
    this.id,
    required this.name,
    this.isFavorite = false,
  });

  RepoModel toModel() => RepoModel(id: key, name: name, isFavorite: isFavorite);

  factory RepoModel.fromJson(Map<String, dynamic> json) => RepoModel(
        id: json['id'],
        name: json['name'],
        isFavorite: json['isFavorite'] ?? false,
      );

  static Map<String, dynamic> toMap(RepoModel repo) => {
        'id': repo.id,
        'name': repo.name,
        'isFavorite': repo.isFavorite,
      };

  static String encode(List<RepoModel> repos) => json.encode(
        repos
            .map<Map<String, dynamic>>((repo) => RepoModel.toMap(repo))
            .toList(),
      );

  static List<RepoModel> decode(String repos) =>
      (json.decode(repos) as List<dynamic>)
          .map<RepoModel>((item) => RepoModel.fromJson(item))
          .toList();
}
