import 'package:detective/domain/result.dart';

class AnalysisById {
  final String id;
  final Result result;

  AnalysisById({
    required this.id,
    required this.result,
  });

  factory AnalysisById.fromJson(Map<String, dynamic> json) {
    return AnalysisById(
      id: json['id'] ?? '',
      result: Result.fromJson(json['result']),
    );
  }
}