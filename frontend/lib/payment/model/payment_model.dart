import 'dart:io';

class Payment {
  late double ammount;
  late File bill;
  late int? id;
  late bool? status;

  Payment({
    this.id,
    required this.ammount,
     this.status,
    required this.bill,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    final filePath = json['bill'];

    // Create a File object from the file path or URL
    final documentFile = File(filePath);
    return Payment(
      ammount: json['ammount'],
      bill: documentFile,
      id: json['id'],
      status: json['status'],
    );
  }
}
