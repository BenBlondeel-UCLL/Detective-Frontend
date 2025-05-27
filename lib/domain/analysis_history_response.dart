import 'package:detective/domain/spelling_mistake.dart';
import 'grammar_mistake.dart';
import 'claim.dart';




// "id": history.id,"title": history.analysis.title,"created_at": history.created_at,
class AnalysisHistoryResponse {
  final String id;
  final String title;
  final String createdAt;

  AnalysisHistoryResponse({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory AnalysisHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AnalysisHistoryResponse(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}