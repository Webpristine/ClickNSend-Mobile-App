// To parse this JSON data, do
//
//     final instructions = instructionsFromJson(jsonString);

import 'dart:convert';

Instructions instructionsFromJson(String str) =>
    Instructions.fromJson(json.decode(str));

String instructionsToJson(Instructions data) => json.encode(data.toJson());

class Instructions {
  String viewData;

  Instructions({
    required this.viewData,
  });

  factory Instructions.fromJson(Map<String, dynamic> json) => Instructions(
        viewData: json["view_data"],
      );

  Map<String, dynamic> toJson() => {
        "view_data": viewData,
      };
}
