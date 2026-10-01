import 'dart:convert';

import 'package:flutter/services.dart';

class LearningResource {
  const LearningResource({
    required this.title,
    required this.descriptions,
    required this.url,
  });

  factory LearningResource.fromJson(Map<String, dynamic> json) {
    return LearningResource(
      title: json['title'] as String,
      descriptions: Map<String, String>.from(json['descriptions'] as Map),
      url: json['url'] as String,
    );
  }

  final String title;
  final Map<String, String> descriptions;
  final String url;

  String localizedDescription(String languageCode) =>
      descriptions[languageCode] ?? descriptions['en'] ?? '';
}

Future<List<LearningResource>> loadLearningResources() async {
  final raw = await rootBundle.loadString(
    'assets/data/learning_resources.json',
  );
  final data = jsonDecode(raw) as Map<String, dynamic>;
  final list = data['resources'] as List<dynamic>;
  return list
      .map((e) => LearningResource.fromJson(e as Map<String, dynamic>))
      .toList();
}
