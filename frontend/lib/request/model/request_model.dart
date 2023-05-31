import 'dart:io';

class Request {
  late String? updatedAt;
  late String description;
  late File police_report;
  late int? id;
  late bool? status;
  final File supported_document;
  late double? loss;
  late double? insured_payment;

  Request(
      {this.updatedAt,
      required this.description,
      required this.police_report,
      this.id,
      this.status,
      required this.supported_document,
      this.loss,
      this.insured_payment,

      
      });

  factory Request.fromJson(Map<String, dynamic> json) {
    final filePath = json['police_report'];
    final filePaths = json['supported_document'];

    // Create a File object from the file path or URL
    final documentFile = File(filePath);
    final myDocument = File(filePaths);
    return Request(
        updatedAt: json['updatedAt'],
        description: json['description'],
        id: json['id'],
        police_report: documentFile,
        status: json['status'],
        loss: json['loss'],
        supported_document: myDocument,
        insured_payment: json['insured_payment']
        
        );
  }
}
