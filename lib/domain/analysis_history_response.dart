import 'package:detective/domain/spelling_mistake.dart';
import 'grammar_mistake.dart';
import 'claim.dart';




// "id": history.id,"title": history.analysis.title,"created_at": history.created_at,
class AnalysisHistoryResponse {
  final String id;
  final String title;
  final String created_at;

  AnalysisHistoryResponse({
    required this.id,
    required this.title,
    required this.created_at,
  });

  factory AnalysisHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AnalysisHistoryResponse(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      created_at: json['created_at'] ?? '',
    );
  }
}