import 'dart:io';

class Payment {
  final int? userId;
  final File? transactionImage;
  final int? paymentAmount;
  final int? transactionId;
  final int? insuranceId;

  Payment({
    this.transactionId,
    this.transactionImage,
    this.paymentAmount,
    this.userId,
    this.insuranceId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      transactionId: json['naymentId'],
      transactionImage: json['qrcodeImage'],
      paymentAmount: json['paymentAmount'],
      insuranceId: json['insuranceId'],
      userId: json['userId'],
    );
  }
}
