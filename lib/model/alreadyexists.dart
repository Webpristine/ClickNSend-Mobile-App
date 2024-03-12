// To parse this JSON data, do
//
//     final alreadyExists = alreadyExistsFromJson(jsonString);

import 'dart:convert';

AlreadyExists alreadyExistsFromJson(String str) =>
    AlreadyExists.fromJson(json.decode(str));

String alreadyExistsToJson(AlreadyExists data) => json.encode(data.toJson());

class AlreadyExists {
  Error error;

  AlreadyExists({
    required this.error,
  });

  factory AlreadyExists.fromJson(Map<String, dynamic> json) => AlreadyExists(
        error: Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error.toJson(),
      };
}

class Error {
  List<String> email;
  List<String> mobile;

  List<String> dialcode;

  Error({
    required this.email,
    required this.dialcode,
    required this.mobile,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        email: json["email"] != null
            ? List<String>.from(json["email"].map((x) => x)).toList()
            : [],
        dialcode: json["dial_code"] != null
            ? List<String>.from(json["dial_code"].map((x) => x)).toList()
            : [],
        mobile: json["mobile"] != null
            ? List<String>.from(json["mobile"].map((x) => x)).toList()
            : [],
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email.map((x) => x)),
        "mobile": List<dynamic>.from(mobile.map((x) => x)),
      };
}
