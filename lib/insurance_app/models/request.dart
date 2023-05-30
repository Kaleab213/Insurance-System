import 'dart:io';

class Request {
  final int? coverage_id;
  final int? insurance_id;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final File? police_report;
  final File? supporting_document;
  final String? userName;
  final int? houseAge;
  final int? houseLocation;
  final int? Number;
  final String? size;
  final int? level;
  final String? witness1Number;
  final String? witness2Number;
  final String? witness3Number;
  final String? paymentAmount;
  final String? status;
  final int? userId;

  Request({
    this.coverage_id,
    this.insurance_id,
    this.createdAt,
    this.updatedAt,
    this.police_report,
    this.supporting_document,
    this.description,
    this.userId,
    this.userName,
    this.houseAge,
    this.houseLocation,
    this.Number,
    this.size,
    this.level,
    this.witness1Number,
    this.witness2Number,
    this.witness3Number,
    this.paymentAmount,
    this.status,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      coverage_id: json['coverage_id'],
      insurance_id: json['insurance_id'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userName: json['userName'],
      level: json['level'],
      houseAge: json['houseAge'],
      houseLocation: json[''],
      Number: json['Number'],
      size: json['size'],
      description: json['description'],
      witness1Number: json['witness1Number'],
      witness2Number: json['witness2Number'],
      witness3Number: json['witness3Number'],
      police_report: json['police_report'],
      supporting_document: json['supporting_document'],
      paymentAmount: json['paymentAmount'],
      status: json['status'],
    );
  }
}
