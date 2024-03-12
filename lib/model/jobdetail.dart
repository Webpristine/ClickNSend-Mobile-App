class JobDetail {
  ViewData? viewData;

  JobDetail({this.viewData});

  JobDetail.fromJson(Map<String, dynamic> json) {
    viewData = json['view_data'] != null
        ? new ViewData.fromJson(json['view_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.viewData != null) {
      data['view_data'] = this.viewData!.toJson();
    }
    return data;
  }
}

class ViewData {
  Job? job;
  List<Pickup>? pickup;
  List<Drop>? drop;
  List<Ratings>? ratings;

  ViewData({this.job, this.pickup, this.drop, this.ratings});

  ViewData.fromJson(Map<String, dynamic> json) {
    job = json['job'] != null ? new Job.fromJson(json['job']) : null;
    if (json['pickup'] != null) {
      pickup = <Pickup>[];
      json['pickup'].forEach((v) {
        pickup!.add(new Pickup.fromJson(v));
      });
    }
    if (json['drop'] != null) {
      drop = <Drop>[];
      json['drop'].forEach((v) {
        drop!.add(new Drop.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.job != null) {
      data['job'] = this.job!.toJson();
    }
    if (this.pickup != null) {
      data['pickup'] = this.pickup!.map((v) => v.toJson()).toList();
    }
    if (this.drop != null) {
      data['drop'] = this.drop!.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Drop {
  int? id;
  int? jobId;
  int? jobitemId;
  Item? item;
  String? address;
  String? lat;
  String? long;
  String? type;
  String? createdAt;
  String? updatedAt;

  Drop(
      {this.id,
      this.jobId,
      this.jobitemId,
      this.item,
      this.address,
      this.lat,
      this.long,
      this.type,
      this.createdAt,
      this.updatedAt});

  Drop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobitemId = json['jobitem_id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['jobitem_id'] = this.jobitemId;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Item {
  int? id;
  int? jobId;
  String? material;
  String? quantity;
  String? length;
  String? height;
  String? width;
  dynamic pickupImages;
  Null? dropImages;
  String? baseUrl;
  String? image;
  String? pickupDate;
  String? pickupTime;
  String? dropDate;
  String? dropTime;
  int? isPickup;
  Null? pickupedAt;
  int? isDrop;
  Null? dropedAt;
  Null? deliveredTo;
  Null? deliveredSign;
  String? createdAt;
  String? updatedAt;

  Item(
      {this.id,
      this.jobId,
      this.material,
      this.quantity,
      this.length,
      this.height,
      this.width,
      this.pickupImages,
      this.dropImages,
      this.baseUrl,
      this.image,
      this.pickupDate,
      this.pickupTime,
      this.dropDate,
      this.dropTime,
      this.isPickup,
      this.pickupedAt,
      this.isDrop,
      this.dropedAt,
      this.deliveredTo,
      this.deliveredSign,
      this.createdAt,
      this.updatedAt});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    material = json['material'];
    quantity = json['quantity'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
    pickupImages = json['pickup_images'];
    dropImages = json['drop_images'];
    baseUrl = json['base_url'];
    image = json['image'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    dropDate = json['drop_date'];
    dropTime = json['drop_time'];
    isPickup = json['is_pickup'];
    pickupedAt = json['pickuped_at'];
    isDrop = json['is_drop'];
    dropedAt = json['droped_at'];
    deliveredTo = json['delivered_to'];
    deliveredSign = json['delivered_sign'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['material'] = this.material;
    data['quantity'] = this.quantity;
    data['length'] = this.length;
    data['height'] = this.height;
    data['width'] = this.width;
    data['pickup_images'] = this.pickupImages;
    data['drop_images'] = this.dropImages;
    data['base_url'] = this.baseUrl;
    data['image'] = this.image;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['drop_date'] = this.dropDate;
    data['drop_time'] = this.dropTime;
    data['is_pickup'] = this.isPickup;
    data['pickuped_at'] = this.pickupedAt;
    data['is_drop'] = this.isDrop;
    data['droped_at'] = this.dropedAt;
    data['delivered_to'] = this.deliveredTo;
    data['delivered_sign'] = this.deliveredSign;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Job {
  int? id;
  int? userId;
  String? createdBy;
  String? name;
  String? budget;
  String? vehicalType;
  String? vehicle;
  String? description;
  int? status;
  String? startedOn;
  String? completedOn;
  int? isDeleted;
  Null? reason;
  String? createdAt;
  String? updatedAt;
  List<Ratings>? ratings;

  Job(
      {this.id,
      this.userId,
      this.createdBy,
      this.name,
      this.budget,
      this.vehicalType,
      this.vehicle,
      this.description,
      this.status,
      this.startedOn,
      this.completedOn,
      this.isDeleted,
      this.reason,
      this.createdAt,
      this.updatedAt,
      this.ratings});

  Job.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    name = json['name'];
    budget = json['budget'];
    vehicalType = json['vehical_type'];
    vehicle = json['vehicle'];
    description = json['description'];
    status = json['status'];
    startedOn = json['started_on'];
    completedOn = json['completed_on'];
    isDeleted = json['is_deleted'];
    reason = json['reason'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(new Ratings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['name'] = this.name;
    data['budget'] = this.budget;
    data['vehical_type'] = this.vehicalType;
    data['vehicle'] = this.vehicle;
    data['description'] = this.description;
    data['status'] = this.status;
    data['started_on'] = this.startedOn;
    data['completed_on'] = this.completedOn;
    data['is_deleted'] = this.isDeleted;
    data['reason'] = this.reason;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.ratings != null) {
      data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ratings {
  int? id;
  int? jobId;
  int? userId;
  String? givenBy;
  int? rating;
  String? review;
  String? createdAt;
  String? updatedAt;

  Ratings(
      {this.id,
      this.jobId,
      this.userId,
      this.givenBy,
      this.rating,
      this.review,
      this.createdAt,
      this.updatedAt});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    userId = json['user_id'];
    givenBy = json['given_by'];
    rating = json['rating'];
    review = json['review'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['user_id'] = this.userId;
    data['given_by'] = this.givenBy;
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Pickup {
  int? id;
  int? jobId;
  int? jobitemId;
  Item? item;
  String? address;
  String? lat;
  String? long;
  String? type;
  String? createdAt;
  String? updatedAt;

  Pickup(
      {this.id,
      this.jobId,
      this.jobitemId,
      this.item,
      this.address,
      this.lat,
      this.long,
      this.type,
      this.createdAt,
      this.updatedAt});

  Pickup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobitemId = json['jobitem_id'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['jobitem_id'] = this.jobitemId;
    if (this.item != null) {
      data['item'] = this.item!.toJson();
    }
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

// class Ratings {
//   int? id;
//   int? userId;
//   User? user;
//   int? jobId;
//   String? givenBy;
//   String? review;
//   int? rating;
//   String? createdAt;
//   String? updatedAt;

//   Ratings(
//       {this.id,
//       this.userId,
//       this.user,
//       this.jobId,
//       this.givenBy,
//       this.review,
//       this.rating,
//       this.createdAt,
//       this.updatedAt});

//   Ratings.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     user = json['user'] != null ? new User.fromJson(json['user']) : null;
//     jobId = json['job_id'];
//     givenBy = json['given_by'];
//     review = json['review'];
//     rating = json['rating'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     // if (this.user != null) {
//     //   data['user'] = this.user!.toJson();
//     // }
//     data['job_id'] = this.jobId;
//     data['given_by'] = this.givenBy;
//     data['review'] = this.review;
//     data['rating'] = this.rating;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

class User {
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

  User(
      {this.id,
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
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['company_id'] = this.companyId;
    data['user_name'] = this.userName;
    data['driver_type'] = this.driverType;
    data['address'] = this.address;
    data['state'] = this.state;
    data['city'] = this.city;
    data['zip_code'] = this.zipCode;
    data['register_type'] = this.registerType;
    data['base_url'] = this.baseUrl;
    data['profile_img'] = this.profileImg;
    data['licence_front'] = this.licenceFront;
    data['licence_back'] = this.licenceBack;
    data['license_expiry'] = this.licenseExpiry;
    data['address_proof'] = this.addressProof;
    data['insurance_cert'] = this.insuranceCert;
    data['transit_cert'] = this.transitCert;
    data['liability_cert'] = this.liabilityCert;
    data['vehicle_cert'] = this.vehicleCert;
    data['v5c_cert'] = this.v5cCert;
    data['dvia_cert'] = this.dviaCert;
    data['nationality_cert'] = this.nationalityCert;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
