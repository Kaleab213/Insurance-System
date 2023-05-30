import 'dart:io';

class Notification {
  final int? notificationId;
  final File? qrcodeImage;
  final int? paymentAmount;
  final int? userId;

  Notification({
    this.notificationId,
    this.qrcodeImage,
    this.paymentAmount,
    this.userId,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notificationId: json['notificationId'],
      qrcodeImage: json['qrcodeImage'],
      paymentAmount: json['paymentAmount'],
      userId: json['userId'],
    );
  }
}
