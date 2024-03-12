// To parse this JSON data, do
//
//     final totalCounts = totalCountsFromJson(jsonString);

import 'dart:convert';

TotalCounts totalCountsFromJson(String str) =>
    TotalCounts.fromJson(json.decode(str));

String totalCountsToJson(TotalCounts data) => json.encode(data.toJson());

class TotalCounts {
  ViewData viewData;

  TotalCounts({
    required this.viewData,
  });

  factory TotalCounts.fromJson(Map<String, dynamic> json) => TotalCounts(
        viewData: ViewData.fromJson(json["view_data"]),
      );

  Map<String, dynamic> toJson() => {
        "view_data": viewData.toJson(),
      };
}

class ViewData {
  int drivers;

  dynamic jobs;
  int earning;
  int bids;

  ViewData({
    required this.drivers,
    required this.jobs,
    required this.earning,
    required this.bids,
  });

  factory ViewData.fromJson(Map<String, dynamic> json) => ViewData(
        drivers: json["drivers"],
        jobs: json["jobs"],
        earning: json["earning"],
        bids: json["bids"],
      );

  Map<String, dynamic> toJson() => {
        "drivers": drivers,

        "jobs": jobs,
        // "amount": amount,
        // "plans": plans,
      };
}
