// To parse this JSON data, do
//
//     final subScriptionPlan = subScriptionPlanFromJson(jsonString);

import 'dart:convert';

SubScriptionPlan subScriptionPlanFromJson(String str) =>
    SubScriptionPlan.fromJson(json.decode(str));

String subScriptionPlanToJson(SubScriptionPlan data) =>
    json.encode(data.toJson());

class SubScriptionPlan {
  List<ViewDatum> viewData;

  SubScriptionPlan({
    required this.viewData,
  });

  factory SubScriptionPlan.fromJson(Map<String, dynamic> json) =>
      SubScriptionPlan(
        viewData: List<ViewDatum>.from(
            json["view_data"].map((x) => ViewDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "view_data": List<dynamic>.from(viewData.map((x) => x.toJson())),
      };
}

class ViewDatum {
  int id;
  String name;
  String createFor;
  int price;
  dynamic startDate;
  dynamic endDate;
  String description;
  int status;
  int viewDatumDefault;
  DateTime createdAt;
  DateTime updatedAt;

  ViewDatum({
    required this.id,
    required this.name,
    required this.createFor,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.status,
    required this.viewDatumDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ViewDatum.fromJson(Map<String, dynamic> json) => ViewDatum(
        id: json["id"],
        name: json["name"],
        createFor: json["create_for"],
        price: json["price"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        description: json["description"],
        status: json["status"],
        viewDatumDefault: json["default"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "create_for": createFor,
        "price": price,
        "start_date": startDate,
        "end_date": endDate,
        "description": description,
        "status": status,
        "default": viewDatumDefault,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
