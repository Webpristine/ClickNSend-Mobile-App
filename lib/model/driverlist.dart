class DriverList {
  ViewData? viewData;

  DriverList({this.viewData});

  DriverList.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null? nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  ViewData(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ViewData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
  int? id;
  String? userType;
  String? email;
  String? mobile;
  int? status;
  int? userId;
  int? companyId;
  String? userName;
  String? driverType;
  Null? address;
  Null? state;
  Null? city;
  Null? zipCode;
  Null? registerType;
  String? baseUrl;
  String? profileImg;
  String? licenceFront;
  String? licenceBack;
  Null? licenseExpiry;
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
  int? totaljob;
  int? runningjob;

  Data(
      {this.id,
      this.userType,
      this.email,
      this.mobile,
      this.status,
      this.userId,
      this.companyId,
      this.userName,
      this.driverType,
      this.address,
      this.state,
      this.city,
      this.zipCode,
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
      this.updatedAt,
      this.totaljob,
      this.runningjob});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    userId = json['user_id'];
    companyId = json['company_id'];
    userName = json['user_name'];
    driverType = json['driver_type'];
    address = json['address'];
    state = json['state'];
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
    totaljob = json['totaljob'];
    runningjob = json['runningjob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
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
    data['totaljob'] = totaljob;
    data['runningjob'] = runningjob;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
