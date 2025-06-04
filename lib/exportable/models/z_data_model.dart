abstract class ZDataModel {
  dynamic id;
  ZDataModel({this.id});
  Map<String, dynamic> toJson();
  ZDataModel fromJson(Map<String, dynamic> json, dynamic id);
}