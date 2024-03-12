import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:click_send/api/api_base_helper.dart';
import 'package:http/http.dart' as http;

class AppRepository {
  ApiBaseHelper helper = ApiBaseHelper();

// Check Moblie Number
  Future<dynamic> douserlogin({
    required String email,
    required String password,
  }) async {
    final response = await helper.post(
      "api/auth/login",
      {
        "email": email,
        "password": password,
      },
      {
        "Accept": "application/json",
      },
    );

    return response;
  }

  // Register API
  Future<dynamic> userregister({
    required String username,
    required String usertype,
    required String mobile,
    required String term,
    required String passwordconfirmation,
    required String email,
    required String dialcode,
    required String password,
  }) async {
    final response = await helper.post(
      "api/user/registration",
      {
        "user_name": username,
        "user_type":
            usertype, //  driver  // company and // customer (Register as field values)
        "email": email,
        "mobile": mobile,
        "term": term, // yes or no
        "dial_code": dialcode,
        "password": password,
        "password_confirmation": passwordconfirmation,
      },
      {
        "Accept": "application/json",
      },
    );

    return response;
  }

  // Send OTP API
  Future<dynamic> sendEmailOTP({
    required String type,
    required String email,
  }) async {
    final response = await helper.post(
      "api/user/send-otp",
      {
        "type": type,
        "email": email,
      },
      {
        "Accept": "application/json",
      },
    );

    return response;
  }

  Future<dynamic> reSendOTP({
    required String type,
    required String email,
  }) async {
    final response = await helper.post(
      "api/user/resend-otp",
      {
        "type": type,
        "email": email,
      },
      {
        "Accept": "application/json",
      },
    );

    return response;
  }

  Future<dynamic> verifyOTP({
    required String otp,
    required String email,
  }) async {
    final response = await helper.post(
      "api/user/validate-otp",
      {
        "otp": otp,
        "email": email,
      },
      {
        "Accept": "application/json",
      },
    );

    return response;
  }

  Future<dynamic> resetpassword({
    required String otp,
    required String password,
    required String passwordconfirmation,
    required String email,
  }) async {
    final response = await helper.post(
      "api/user/reset-password",
      {
        "otp": otp,
        "email": email,
        "password": password,
        "password_confirmation": passwordconfirmation
      },
      {
        "Accept": "application/json",
      },
    );

    return response;
  }

  Future<dynamic> getprofile({required String accesstoken}) async {
    final response = await helper.get(
      "api/auth/profile/my-profile",
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> getvehicletype({required String accesstoken}) async {
    final response = await helper.get(
      "api/auth/default/vehicle-type",
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> getvehiclebody({
    required String accesstoken,
    required String type,
  }) async {
    final response =
        await helper.get("api/auth/default/vehicle-body?type=$type", {
      "Accept": "application/json",
      "Authorization": "Bearer $accesstoken",
    });

    return response;
  }

  Future<dynamic> refreshtoken({
    required String accesstoken,
  }) async {
    final response = await helper.post(
      "api/auth/refresh",
      {},
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );
    log("Token" + response.toString());

    return response;
  }

  Future<dynamic> addnewvehicle({
    required String userid,
    required String ownernumber,
    required String drivernumber,
    required String ownername,
    required String accesstoken,
    required String vehiclenumber,
    required String city,
    required String vehicletype,
    required String vehilceBody,
  }) async {
    final response = await helper.post(
      "api/auth/driver/vehicle-add",
      {
        "user_id": userid,
        "owner_number": ownernumber,
        "driver_number": drivernumber,
        "owner_name": ownername,
        "vehicle_number": vehiclenumber,
        "city": city,
        "vehicle_type": vehicletype,
        "vehicle_body": vehilceBody
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> getinstructions({
    required String accesstoken,
  }) async {
    final response = await helper.get("api/auth/default/get-instruction", {
      "Accept": "application/json",
      "Authorization": "Bearer $accesstoken",
    });

    return response;
  }

  Future<dynamic> driverterms({
    required String accesstoken,
    required String userid,
  }) async {
    final response = await helper.post(
      "api/auth/driver/terms",
      {
        "user_id": userid,
        "term": "yes",
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> getcounts({
    required String accesstoken,
    required String userid,
  }) async {
    final response =
        await helper.get("api/auth/company/dashboard?user_id=$userid", {
      "Accept": "application/json",
      "Authorization": "Bearer $accesstoken",
    });

    return response;
  }

  Future<dynamic> getnotifications({
    required String accesstoken,
  }) async {
    final response = await helper
        .get("api/auth/master/notification/list?type=company?per_page=100", {
      "Accept": "application/json",
      "Authorization": "Bearer $accesstoken",
    });

    return response;
  }

  Future<dynamic> userlogout({
    required String accesstoken,
  }) async {
    final response = await helper.post(
      "api/auth/logout",
      {},
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> updateprofile(
      {required String accesstoken, required String username}) async {
    final response = await helper.post(
      "api/auth/profile/update-profile",
      {
        "user_name": username,
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> updateprofileimage({
    required File image,
    required String username,
    required String accesstoken,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/profile/update-profile";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Create a multipart file from the file path

    var profile = await http.MultipartFile.fromPath('profile_img', image.path);
    request.files.add(profile);

    // Add the file to the request
    request.fields["user_name"] = username;

    request.headers["Authorization"] = "Bearer $accesstoken";
    print(request.fields.toString());
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print(responseBody);

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw UnimplementedError();
    }
  }

  Future<dynamic> uploadvehileimage({
    required File licencefile,
    required File addressfile,
    required File insurancwfile,
    required File gitfile,
    required File liabilityfile,
    required File vehilefile,
    required File dvlafile,
    required File vehiclecertificate,
    required File nationalitycerti,
    required String userid,
    required String accesstoken,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/driver/add-documents/$userid";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Create a multipart file from the file path

    var licnece =
        await http.MultipartFile.fromPath('licence_front', licencefile.path);
    var address =
        await http.MultipartFile.fromPath('address_proof', addressfile.path);
    var insurance =
        await http.MultipartFile.fromPath('insurance_cert', insurancwfile.path);
    var transit =
        await http.MultipartFile.fromPath('transit_cert', gitfile.path);
    var liability =
        await http.MultipartFile.fromPath('liability_cert', liabilityfile.path);
    var vehicecerti = await http.MultipartFile.fromPath(
        'vehicle_cert', vehiclecertificate.path);
    var vimage = await http.MultipartFile.fromPath('V5c_cert', vehilefile.path);
    var dvla = await http.MultipartFile.fromPath('dvia_cert', dvlafile.path);
    var ncerti = await http.MultipartFile.fromPath(
        'nationality_cert', nationalitycerti.path);

    request.files.add(licnece);
    request.files.add(address);
    request.files.add(insurance);
    request.files.add(transit);
    request.files.add(liability);
    request.files.add(vehicecerti);
    request.files.add(vimage);
    request.files.add(dvla);
    request.files.add(ncerti);

    // Add the file to the request

    request.headers["Authorization"] = "Bearer $accesstoken";
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print(responseBody);

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw UnimplementedError();
    }
  }

  Future<dynamic> uploadcompanydoc({
    required File certi,
    required File vat,
    required String userid,
    required String accesstoken,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/company/add-documents/$userid";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Create a multipart file from the file path

    var address = await http.MultipartFile.fromPath(
      'company_certificate',
      certi.path,
    );

    request.files.add(address);
    if (vat.path.isNotEmpty) {
      var insurance = await http.MultipartFile.fromPath(
        'company_vat',
        vat.path,
      );
      request.files.add(insurance);
    }
    // Add the file to the request

    request.headers["Authorization"] = "Bearer $accesstoken";
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw UnimplementedError();
    }
  }

  Future<dynamic> updatepassword({
    required String accesstoken,
    required String password,
  }) async {
    final response = await helper.post(
      "api/auth/profile/update-password",
      {
        "new_password_confirmation": password,
        "new_password": password,
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> companytems({
    required String accesstoken,
    required String userid,
  }) async {
    final response = await helper.post(
      "api/auth/company/terms",
      {
        "user_id": userid,
        "term": "yes",
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> checkdriversteps({
    required String accesstoken,
    required String step,
    required String userid,
  }) async {
    final response = await helper.post(
      "api/auth/driver/step-check",
      {
        "user_id": userid,
        "step": step,
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );
    print("data is $response");
    return response;
  }

  Future<dynamic> checkcompanysteps({
    required String accesstoken,
    required String userid,
    required String step,
  }) async {
    final response = await helper.post(
      "api/auth/company/step-check",
      {
        "user_id": userid,
        "step": step,
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );
    print("data is $response");
    return response;
  }

  Future<dynamic> companydriverlist({
    required String accesstoken,
    required String userid,
  }) async {
    final response = await helper.post(
      "api/auth/company/driver-list",
      {
        "user_id": userid,
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );
    return response;
  }

  Future<dynamic> driverbidstatic({
    required String accesstoken,
    required String userid,
  }) async {
    final response = await helper.get(
      "api/driver/bid-statics/$userid",
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );
    return response;
  }

  Future<dynamic> uploadcompanyvehicle({
    required File image,
    required String userid,
    required String accesstoken,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/company/vehicle-image";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Create a multipart file from the file path

    var address = await http.MultipartFile.fromPath(
      'vehicle_image',
      image.path,
    );

    request.files.add(address);

    // Add the file to the request

    request.headers["Authorization"] = "Bearer $accesstoken";
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print(responseBody);

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw UnimplementedError();
    }
  }

  Future<dynamic> companyeditprofile({
    required String accesstoken,
    required String userid,
  }) async {
    final response = await helper.get(
      "api/auth/company/edit-driver/$userid",
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> uploadcompanydriver({
    required File licencefile,
    required File addressfile,
    required File insurancwfile,
    required File gitfile,
    required File liabilityfile,
    required File vehilefile,
    required File dvlafile,
    required File vehiclecertificate,
    required File nationalitycerti,
    required String userid,
    required File licencebackfile,
    required String username,
    required String usertype,
    required String accesstoken,
    required String email,
    required String drivertype,
    required String mobile,
    required String password,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/company/add-driver/$userid";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Create a multipart file from the file path

    var licnece =
        await http.MultipartFile.fromPath('licence_front', licencefile.path);
    var licenceback =
        await http.MultipartFile.fromPath('licence_back', licencebackfile.path);
    var address =
        await http.MultipartFile.fromPath('address_proof', addressfile.path);
    var insurance =
        await http.MultipartFile.fromPath('insurance_cert', insurancwfile.path);
    var transit =
        await http.MultipartFile.fromPath('transit_cert', gitfile.path);
    var liability =
        await http.MultipartFile.fromPath('liability_cert', liabilityfile.path);
    var vehicecerti = await http.MultipartFile.fromPath(
        'vehicle_cert', vehiclecertificate.path);
    var vimage = await http.MultipartFile.fromPath('V5c_cert', vehilefile.path);
    var dvla = await http.MultipartFile.fromPath('dvia_cert', dvlafile.path);
    var ncerti = await http.MultipartFile.fromPath(
        'nationality_cert', nationalitycerti.path);

    request.files.add(licnece);
    request.fields["user_name"] = username;
    request.fields["user_type"] = usertype;
    request.fields["email"] = email;
    request.fields["mobile"] = mobile;
    request.fields["driver_type"] = drivertype;
    request.fields["password"] = password;
    request.fields["password_confirmation"] = password;
    request.files.add(licenceback);

    request.files.add(address);
    request.files.add(insurance);
    request.files.add(transit);
    request.files.add(liability);
    request.files.add(vehicecerti);
    request.files.add(vimage);
    request.files.add(dvla);
    request.files.add(ncerti);

    // Add the file to the request

    request.headers["Authorization"] = "Bearer $accesstoken";
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print(responseBody);

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw UnimplementedError();
    }
  }

  Future<dynamic> updatecompanydriver({
    required File licencefile,
    required File addressfile,
    required File insurancwfile,
    required File gitfile,
    required File liabilityfile,
    required File vehilefile,
    required File dvlafile,
    required File vehiclecertificate,
    required File nationalitycerti,
    required String driverid,
    required File licencebackfile,
    required String username,
    required String usertype,
    required String accesstoken,
    required String email,
    required String drivertype,
    required String mobile,
    required String password,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/company/update-driver/$driverid";
    final request = http.MultipartRequest('POST', Uri.parse(url));

    // Create a multipart file from the file path

    var licnece =
        await http.MultipartFile.fromPath('licence_front', licencefile.path);
    var licenceback =
        await http.MultipartFile.fromPath('licence_back', licencebackfile.path);
    var address =
        await http.MultipartFile.fromPath('address_proof', addressfile.path);
    var insurance =
        await http.MultipartFile.fromPath('insurance_cert', insurancwfile.path);
    var transit =
        await http.MultipartFile.fromPath('transit_cert', gitfile.path);
    var liability =
        await http.MultipartFile.fromPath('liability_cert', liabilityfile.path);
    var vehicecerti = await http.MultipartFile.fromPath(
        'vehicle_cert', vehiclecertificate.path);
    var vimage = await http.MultipartFile.fromPath('V5c_cert', vehilefile.path);
    var dvla = await http.MultipartFile.fromPath('dvia_cert', dvlafile.path);
    var ncerti = await http.MultipartFile.fromPath(
        'nationality_cert', nationalitycerti.path);

    request.files.add(licnece);
    request.fields["user_name"] = username;
    // request.fields["user_type"] = usertype;
    // request.fields["email"] = email;
    // request.fields["mobile"] = mobile;
    request.fields["driver_type"] = drivertype;
    // request.fields["password"] = password;
    // request.fields["password_confirmation"] = password;
    request.files.add(licenceback);

    request.files.add(address);
    request.files.add(insurance);
    request.files.add(transit);
    request.files.add(liability);
    request.files.add(vehicecerti);
    request.files.add(vimage);
    request.files.add(dvla);
    request.files.add(ncerti);

    // Add the file to the request

    request.headers["Authorization"] = "Bearer $accesstoken";
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    print(responseBody);

    if (response.statusCode == 200) {
      return jsonDecode(responseBody);
    } else {
      throw UnimplementedError();
    }
  }

  Future<dynamic> getAllJobList({
    required String accessToken,
    required String userid,
    required String type,
  }) async {
    String url =
        "api/auth/jobs/list?&type=$type&page=1&pageSize=10&user_id=$userid";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    // log(response.toString());
    return response;
  }

  Future<dynamic> getJobList({
    required String accessToken,
    required String userid,
    required String status,
    required String type,
    required String latitude,
    required String longitude,
  }) async {
    String url =
        "api/auth/jobs/list?status=$status&type=$type&page=1&pageSize=10&user_id=$userid&lat=$latitude&long=$longitude";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    // log(response.toString());
    return response;
  }

  Future<dynamic> getalljobs({
    required String accessToken,
    required String userid,
    required String type,
    required String latitude,
    required String longitude,
  }) async {
    String url =
        "api/auth/jobs/list?type=$type&user_id=$userid&lat=$latitude&long=$longitude";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    // log(response.toString());
    return response;
  }

  Future<dynamic> getJobListByDate({
    required String accessToken,
    required String userid,
    required String status,
    required String type,
    required String date,
  }) async {
    //date=2023-12-21
    String url =
        "api/auth/jobs/list?status=$status&type=$type&page=1&pageSize=10&user_id=$userid&date=$date";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    // log(response.toString());
    return response;
  }

  Future<dynamic> getJobDetails({
    required String accessToken,
    required String jobId,
  }) async {
    String url = "api/auth/jobs/view/$jobId";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    return response;
  }

  Future<dynamic> getJobAddress({
    required String accessToken,
    required String jobId,
  }) async {
    String url = "api/auth/jobs/job-address/$jobId";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get job address');
    }
  }

  Future<dynamic> applyBid({
    required String accessToken,
    required String jobId,
    required String driverId,
    required double amount,
    required String description,
    required String isApply,
  }) async {
    String url = "api/auth/jobs/apply-bid";
    final response = await helper.post(
      url,
      {
        "job_id": jobId,
        "driver_id": driverId,
        "ammount": amount.toString(),
        "description": description,
        "is_apply": isApply.toString(),
      },
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    return response;
  }

  Future<dynamic> getJobBids({
    required String accessToken,
    required String jobId,
  }) async {
    String url = "api/auth/jobs/job-bids/$jobId";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get job bids');
    }
  }

  Future<dynamic> startJob({
    required String accessToken,
    required String id,
    required String driverId,
  }) async {
    String url = "api/auth/jobs/start-job";
    final response = await helper.post(
      url,
      {
        "id": id,
        "driver_id": driverId,
      },
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to start job');
    }
  }

  Future<dynamic> trackJob({
    required String accessToken,
    required String bidId,
    required String jobId,
    required String userId,
  }) async {
    String url = "api/auth/jobs/track-job";
    final response = await helper.post(
      url,
      {
        "bid_id": bidId,
        "job_id": jobId,
        "user_id": userId,
      },
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to track job');
    }
  }

  Future<dynamic> getDriverDashboard({
    required String accessToken,
    required String userId,
  }) async {
    String url = "api/driver/dashboard?user_id=$userId";
    final response = await helper.get(
      url,
      {
        "Authorization": "Bearer $accessToken",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get driver dashboard');
    }
  }

  Future<dynamic> itemPickDrop({
    required String accessToken,
    required String jobId,
    required String itemId,
    required List<File> images,
    required String type,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/driver/item-pick-drop/$jobId";

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Set the headers
    request.headers['Authorization'] = 'Bearer $accessToken';

    // Add the item_id and type as fields
    request.fields['item_id'] = itemId;
    request.fields['type'] = type;

    // Add the images as files
    for (var i = 0; i < images.length; i++) {
      var file = images[i];
      var stream = http.ByteStream(
        Stream.castFrom(
          file.openRead(),
        ),
      );
      var length = await file.length();
      var multipartFile =
          http.MultipartFile('images', stream, length, filename: (file.path));
      request.files.add(multipartFile);
    }

    // Send the request and get the response
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to pick/drop item');
    }
  }

  Future<dynamic> itemDelivered({
    required String accessToken,
    required String jobId,
    required String itemId,
    required File sign,
    required String name,
    required String type,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/driver/item-delivered/$jobId";

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Set the headers
    request.headers['Authorization'] = 'Bearer $accessToken';

    // Add the item_id, name, and type as fields
    request.fields['item_id'] = itemId;
    request.fields['name'] = name;
    request.fields['type'] = type;

    // Add the sign as a file
    var stream = http.ByteStream(Stream.castFrom(sign.openRead()));
    var length = await sign.length();
    var multipartFile =
        http.MultipartFile('sign', stream, length, filename: sign.path);
    request.files.add(multipartFile);

    // Send the request and get the response
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to deliver item');
    }
  }

  Future<dynamic> addrating({
    required String accessToken,
    required String jobId,
    required String userid,
    required File image,
    required String givenby,
    required String review,
    required int rating,
  }) async {
    String url =
        "https://webpristine.com/work/clickandsend/api/auth/rating/add";

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Set the headers
    request.headers['Authorization'] = 'Bearer $accessToken';

    // Add the item_id, name, and type as fields
    request.fields["user_id"] = userid;
    request.fields["job_id"] = jobId;
    var profile = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(profile);

    request.fields['given_by'] = givenby;
    request.fields['review'] = review;
    request.fields['rating'] = rating.toString();

    // Send the request and get the response
    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print("Job is $responseBody");
    // Check the response status code
    // if (response.statusCode == 200) {

    //   return jsonDecode(responseBody);
    // } else {
    //   throw Exception('Failed to deliver item');
    // }
  }

  Future<dynamic> addcompanyinfo({
    required String userid,
    required String username,
    required String address,
    required String drivernumber,
    required String vehiclenumber,
    required String vehicletype,
    required String vehiclebody,
    required String accesstoken,
  }) async {
    final response = await helper.post(
      "api/auth/company/add-info",
      {
        "user_id": userid,
        "user_name": username,
        "address": address,
        "vehicles": jsonEncode([
          {
            "driver_number": drivernumber,
            "vehicle_number": vehiclenumber,
            "vehicle_type": vehicletype,
            'vehicle_body': vehiclebody,
            "image": "image"
          }
        ])
      },
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> socialLogin({
    required String email,
  }) async {
    final response = await helper.post(
      "api/auth/social-login",
      {
        "social_type": "gmail",
        "email": email,
      },
      {
        "Accept": "application/json",
      },
    );

    return response;
  }

  //auth/company/driver-list?page=1&pageSize=10&user_id=268

  Future<dynamic> fetchdriverlist({
    required String userid,
    required String accesstoken,
  }) async {
    final response = await helper.get(
      "api/auth/company/driver-list?user_id=$userid",
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }
  //api/auth/master/plan/list/driver

  Future<dynamic> fetchdriverplan({
    required String accesstoken,
    required String usertype,
  }) async {
    final response = await helper.get(
      "api/auth/master/plan/list/$usertype",
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }

  Future<dynamic> fetchinvoice({
    required String accesstoken,
    required String userid,
  }) async {
    final response = await helper.get(
      "api/auth/invoice/list?user_id=$userid",
      {
        "Accept": "application/json",
        "Authorization": "Bearer $accesstoken",
      },
    );

    return response;
  }
}
