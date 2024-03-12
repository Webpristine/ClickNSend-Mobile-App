class User {
  ViewData? viewData;

  User({this.viewData});

  User.fromJson(Map<String, dynamic> json) {
    viewData =
        json['view_data'] != null ? ViewData.fromJson(json['view_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (viewData != null) {
      data['view_data'] = viewData!.toJson();
    }
    return data;
  }
}

class ViewData {
  int? id;
  String? userType;
  dynamic socialType;
  String? email;
  String? mobile;
  int? status;
  String? planName;
  Plan? plan;
  String? createdAt;
  String? updatedAt;
  Profile? profile;

  ViewData(
      {this.id,
      this.userType,
      this.socialType,
      this.email,
      this.mobile,
      this.status,
      this.planName,
      this.plan,
      this.createdAt,
      this.updatedAt,
      this.profile});

  ViewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    socialType = json['social_type'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    planName = json['plan_name'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['social_type'] = socialType;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
    data['plan_name'] = planName;
    if (plan != null) {
      data['plan'] = plan!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    return data;
  }
}

class Plan {
  int? id;
  int? planId;
  int? userId;
  String? startDate;
  String? endDate;
  int? status;

  Plan(
      {this.id,
      this.planId,
      this.userId,
      this.startDate,
      this.endDate,
      this.status});

  Plan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planId = json['plan_id'];
    userId = json['user_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['plan_id'] = planId;
    data['user_id'] = userId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['status'] = status;
    return data;
  }
}

class Profile {
  int? id;
  int? userId;
  int? companyId;
  String? userName;
  String? driverType;
  String? address;
  String? state;
  String? city;
  String? zipCode;
  String? registerType;
  String? baseUrl;
  String? profileImg;
  String? licenceFront;
  String? companylogo;
  String? licenceBack;
  String? licenseExpiry;
  String? addressProof;
  String? insuranceCert;
  String? transitCert;
  String? liabilityCert;
  String? vehicleCert;
  String? v5cCert;
  String? dviaCert;
  String? nationalityCert;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.userId,
      this.companyId,
      this.userName,
      this.driverType,
      this.address,
      this.state,
      this.city,
      this.zipCode,
      this.companylogo,
      this.registerType,
      this.baseUrl,
      this.profileImg,
      this.licenceFront,
      this.licenceBack,
      this.licenseExpiry,
      this.addressProof,
      this.insuranceCert,
      this.transitCert,
      this.liabilityCert,
      this.vehicleCert,
      this.v5cCert,
      this.dviaCert,
      this.nationalityCert,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    companyId = json['company_id'];
    userName = json['user_name'];
    driverType = json['driver_type'];
    address = json['address'];
    state = json['state'];
    companylogo = json["company_logo"];
    city = json['city'];
    zipCode = json['zip_code'];
    registerType = json['register_type'];
    baseUrl = json['base_url'];
    profileImg = json['profile_img'];
    licenceFront = json['licence_front'];
    licenceBack = json['licence_back'];
    licenseExpiry = json['license_expiry'];
    addressProof = json['address_proof'];
    insuranceCert = json['insurance_cert'];
    transitCert = json['transit_cert'];
    liabilityCert = json['liability_cert'];
    vehicleCert = json['vehicle_cert'];
    v5cCert = json['v5c_cert'];
    dviaCert = json['dvia_cert'];
    nationalityCert = json['nationality_cert'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['company_id'] = companyId;
    data['user_name'] = userName;
    data['driver_type'] = driverType;
    data['address'] = address;
    data['state'] = state;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['register_type'] = registerType;
    data['base_url'] = baseUrl;
    data['profile_img'] = profileImg;
    data['licence_front'] = licenceFront;
    data['licence_back'] = licenceBack;
    data['license_expiry'] = licenseExpiry;
    data['address_proof'] = addressProof;
    data['insurance_cert'] = insuranceCert;
    data['transit_cert'] = transitCert;
    data['liability_cert'] = liabilityCert;
    data['vehicle_cert'] = vehicleCert;
    data['v5c_cert'] = v5cCert;
    data['dvia_cert'] = dviaCert;
    data['nationality_cert'] = nationalityCert;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
