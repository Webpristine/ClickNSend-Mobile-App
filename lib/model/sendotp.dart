// To parse this JSON data, do
//
//     final sendOtpResponse = sendOtpResponseFromJson(jsonString);

import 'dart:convert';

SendOtpResponse sendOtpResponseFromJson(String str) =>
    SendOtpResponse.fromJson(json.decode(str));

String sendOtpResponseToJson(SendOtpResponse data) =>
    json.encode(data.toJson());

class SendOtpResponse {
  String message;
  int verificationCode;

  SendOtpResponse({
    required this.message,
    required this.verificationCode,
  });

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) =>
      SendOtpResponse(
        message: json["message"],
        verificationCode: json["verification_code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "verification_code": verificationCode,
      };
}
