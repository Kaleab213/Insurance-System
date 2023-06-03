class Notifications {
  late final String note;
  final String id;
 
  final String title;

  Notifications({required this.note, required this.id, required this.title});

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
        note: json['Description'], id: json['id'], title: json["title"]);
  }
}
