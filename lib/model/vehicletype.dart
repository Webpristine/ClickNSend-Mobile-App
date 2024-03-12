// To parse this JSON data, do
//
//     final vehicleType = vehicleTypeFromJson(jsonString);

import 'dart:convert';

VehicleType vehicleTypeFromJson(String str) =>
    VehicleType.fromJson(json.decode(str));

String vehicleTypeToJson(VehicleType data) => json.encode(data.toJson());

class VehicleType {
  List<String> viewData;

  VehicleType({
    required this.viewData,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) => VehicleType(
        viewData: List<String>.from(json["view_data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "view_data": List<dynamic>.from(viewData.map((x) => x)),
      };
}
