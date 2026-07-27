
class DropDownModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  DropDownModel({this.userId, this.id, this.title, this.body});

  DropDownModel.fromJson(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
    body = json["body"];
  }

  static List<DropDownModel> fromList(List<Map<String, dynamic>> list) {
    return list.map(DropDownModel.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["userId"] = userId;
    _data["id"] = id;
    _data["title"] = title;
    _data["body"] = body;
    return _data;
  }
}