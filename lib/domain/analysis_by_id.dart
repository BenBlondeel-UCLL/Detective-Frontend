import 'package:detective/domain/result.dart';

class AnalysisById {
  final String id;
  final String article;
  final Result result;

  AnalysisById({
    required this.id,
    required this.article,
    required this.result,
  });

  factory AnalysisById.fromJson(Map<String, dynamic> json) {
    return AnalysisById(
      id: json['id'] ?? '',
      article: json['article'] ?? '',
      result: Result.fromJson(json['result']),
    );
  }
}