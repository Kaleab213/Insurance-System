import 'dart:io';

class Insurance {
  late File? telebirr_QR;
  late String location;
  late int size;
  late int room;
  late String type;
  late String level;
  late int? id;
  final bool? status;
  late File? Document;
  late double? deposit;
  late double? monthly_payment;
  late List? coverage_request;
  late List? payment;
  

  Insurance({
    required this.location,
    this.telebirr_QR,
    this.id,
    this.deposit,
    required this.size,
    required this.room,
    required this.type,
    required this.level,
    this.status,
    this.Document,
    this.monthly_payment,
    this.coverage_request,
    this.payment,
  });

  factory Insurance.fromJson(Map<String, dynamic> json) {
    final filePath = json['Document'];

    // Create a File object from the file path or URL
    final documentFile = File(filePath);
    return Insurance(
      location: json['location'],
      telebirr_QR: json['telebirr_QR'],
      id: json['id'],
      deposit: json['deposit'].toDouble(),
      size: json['size'],
      room: json['room'],
      level: json['coveragelevel'],
      status: json['status'],
      type: json['propertytype'],
      Document: documentFile,
    );
    // coverage_request: json['coverege_request']);
  }
  Map<String, dynamic> toMap() {
    print("insurance to map");
    return {
      'location': location,
      'telebirr_QR': telebirr_QR?.path,
      'size': size,
      'room': room,
      'propertytype': type,
      'coveragelevel': level,
      'id': id,
      'status': status,
      'Document': Document!.path,
      'deposit': deposit,
      'monthly_payment': monthly_payment,
      'coverage_request': coverage_request,
      "payment": payment,
    };
  }
}
