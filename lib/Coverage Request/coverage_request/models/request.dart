import 'dart:io';

class Request {
  final int? coverage_id;
  final int? insurance_id;
  final String? description;
  final String date;
  final File police_report;
  final File supporting_document;

  Request(
      {required this.coverage_id,
      required this.insurance_id,
      required this.date,
      required this.police_report,
      required this.supporting_document,
      required this.description});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
        coverage_id: json['coverage_id'],
        insurance_id: json['insurance_id'],
        date: json['date'],
        police_report: json['police_report'],
        supporting_document: json['supporting_document'],
        description: json['description']);
  }
}
