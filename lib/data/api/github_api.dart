import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../presentation/models/repo_model.dart';

class GitHubApi {
  static const _baseUrl = 'https://api.github.com';
  static final http.Client client = http.Client();

  Future<List<RepoModel>> getRepos(String query, int currentPage) async {
    final url =
        '$_baseUrl/search/repositories?q=$query&sort=stars&order=desc&page=$currentPage&per_page=15';

    final http.Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);

      return List<RepoModel>.from(
        decoded['items'].map((repo) => RepoModel.fromJson(repo)),
      );
    } else {
      debugPrint('Failed to load data');
      return [];
    }
  }
}
