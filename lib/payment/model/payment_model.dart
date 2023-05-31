import 'dart:io';

class Payment {
  final String date;
  final File qrcode;
  final File image;
  final int id;
  final int amount;

  Payment({
    required this.date,
    required this.qrcode,
    required this.image,
    required this.id,
    required this.amount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      date: json['date'],
      qrcode: json['qrcode'],
      image: json['image'],
      id: json['id'],
      amount: json['amount'],

    );
  }
}