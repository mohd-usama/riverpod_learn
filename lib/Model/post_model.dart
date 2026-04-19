class PostModel {
  int? localId;
  int? userId;
  int? id;
  String? title;
  String? body;
  bool isFav;

  PostModel({
    this.localId,
    this.userId,
    this.id,
    this.title,
    this.body,
    this.isFav = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      localId: json['localId'],
      userId: int.tryParse(json['userId'].toString()),
      id: int.tryParse(json['id'].toString()),
      title: json['title'],
      body: json['body'],
      isFav: json['isFav'] == 1 || json['isFav'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
      'isFav': isFav ? 1 : 0,
    };
  }
}
