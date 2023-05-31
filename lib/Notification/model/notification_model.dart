class Notifications {
  late final String note;
  final String id;
  final int userID;

  Notifications({required this.note, required this.id, required this.userID});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(note: json['note'], id: json['id'], userID: json['userID']);
  }
}
