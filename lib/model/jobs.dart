class Jobs {
  ViewData? viewData;

  Jobs({this.viewData});

  Jobs.fromJson(Map<String, dynamic> json) {
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
  List<Data>? data;
  Links? links;
  Meta? meta;

  ViewData({this.data, this.links, this.meta});

  ViewData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? createdBy;
  String? name;
  String? budget;
  int? spentmoney;
  String? vehicalType;
  String? vehicle;
  String? description;
  int? status;
  String? startedOn;
  String? completedOn;
  int? isDeleted;
  int? bidDriver;
  int? driverId;
  int? bidId;
  AcceptBid? acceptBid;
  List<JobRequests>? jobRequests;
  List<Items>? items;
  List<Null>? ratings;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.createdBy,
      this.name,
      this.budget,
      this.spentmoney,
      this.vehicalType,
      this.vehicle,
      this.description,
      this.status,
      this.startedOn,
      this.completedOn,
      this.isDeleted,
      this.bidDriver,
      this.driverId,
      this.bidId,
      this.acceptBid,
      this.jobRequests,
      this.items,
      this.ratings,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    name = json['name'];
    budget = json['budget'];
    spentmoney = json['spentmoney'];
    vehicalType = json['vehical_type'];
    vehicle = json['vehicle'];
    description = json['description'];
    status = json['status'];
    startedOn = json['started_on'];
    completedOn = json['completed_on'];
    isDeleted = json['is_deleted'];
    bidDriver = json['bid_driver'];
    driverId = json['driver_id'];
    bidId = json['bid_id'];
    acceptBid = json['accept_bid'] != ""
        ? new AcceptBid.fromJson(json['accept_bid'])
        : null;
    if (json['job_requests'] != null) {
      jobRequests = <JobRequests>[];
      json['job_requests'].forEach((v) {
        jobRequests!.add(new JobRequests.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Null>[];
      json['ratings'].forEach((v) {
        // ratings!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['name'] = this.name;
    data['budget'] = this.budget;
    data['spentmoney'] = this.spentmoney;
    data['vehical_type'] = this.vehicalType;
    data['vehicle'] = this.vehicle;
    data['description'] = this.description;
    data['status'] = this.status;
    data['started_on'] = this.startedOn;
    data['completed_on'] = this.completedOn;
    data['is_deleted'] = this.isDeleted;
    data['bid_driver'] = this.bidDriver;
    data['driver_id'] = this.driverId;
    data['bid_id'] = this.bidId;
    if (this.acceptBid != null) {
      data['accept_bid'] = this.acceptBid!.toJson();
    }
    if (this.jobRequests != null) {
      data['job_requests'] = this.jobRequests!.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.ratings != null) {
      // data['ratings'] = this.ratings!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class AcceptBid {
  int? id;
  int? jobId;
  int? driverId;
  int? earning;
  dynamic rating;
  dynamic jobpercent;
  List<Items>? items;
  List<Address>? address;
  Driver? driver;
  int? isApply;
  String? applyAt;
  String? description;
  String? ammount;
  int? status;
  String? createdAt;
  String? updatedAt;

  AcceptBid(
      {this.id,
      this.jobId,
      this.driverId,
      this.earning,
      this.rating,
      this.jobpercent,
      this.items,
      this.address,
      this.driver,
      this.isApply,
      this.applyAt,
      this.description,
      this.ammount,
      this.status,
      this.createdAt,
      this.updatedAt});

  AcceptBid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    driverId = json['driver_id'];
    earning = json['earning'];
    rating = json['rating'];
    jobpercent = json['jobpercent'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    isApply = json['is_apply'];
    applyAt = json['apply_at'];
    description = json['description'];
    ammount = json['ammount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['driver_id'] = this.driverId;
    data['earning'] = this.earning;
    data['rating'] = this.rating;
    data['jobpercent'] = this.jobpercent;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['is_apply'] = this.isApply;
    data['apply_at'] = this.applyAt;
    data['description'] = this.description;
    data['ammount'] = this.ammount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Items {
  Product? product;
  List<Address>? address;

  Items({this.product, this.address});

  Items.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  int? jobId;
  String? quantity;
  String? material;
  String? length;
  String? height;
  String? width;
  String? baseUrl;
  String? image;
  String? pickupDate;
  String? pickupTime;
  String? dropDate;
  String? dropTime;
  int? isPickup;
  dynamic pickupedAt;
  int? isDrop;
  dynamic dropedAt;
  dynamic pickupImages;
  dynamic dropImages;
  dynamic deliveredTo;
  dynamic deliveredSign;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.jobId,
      this.quantity,
      this.material,
      this.length,
      this.height,
      this.width,
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
      this.pickupImages,
      this.dropImages,
      this.deliveredTo,
      this.deliveredSign,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    quantity = json['quantity'];
    material = json['material'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
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
    pickupImages = json['pickup_images'];
    dropImages = json['drop_images'];
    deliveredTo = json['delivered_to'];
    deliveredSign = json['delivered_sign'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['quantity'] = this.quantity;
    data['material'] = this.material;
    data['length'] = this.length;
    data['height'] = this.height;
    data['width'] = this.width;
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
    data['pickup_images'] = this.pickupImages;
    data['drop_images'] = this.dropImages;
    data['delivered_to'] = this.deliveredTo;
    data['delivered_sign'] = this.deliveredSign;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Address {
  int? id;
  int? jobId;
  int? jobitemId;
  Product? item;
  String? address;
  String? lat;
  String? long;
  String? type;
  String? createdAt;
  String? updatedAt;

  Address(
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

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    jobitemId = json['jobitem_id'];
    item = json['item'] != null ? new Product.fromJson(json['item']) : null;
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

class Driver {
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

  Driver(
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

  Driver.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? first;
  String? last;
  Null? prev;
  dynamic next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.links,
      this.path,
      this.perPage,
      this.to,
      this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class JobRequests {
  int? id;
  int? jobId;
  int? driverId;
  int? earning;
  dynamic rating;
  dynamic jobpercent;
  List<Items>? items;
  List<Address>? address;
  Driver? driver;
  int? isApply;
  String? applyAt;
  String? description;
  String? ammount;
  int? status;
  String? createdAt;
  String? updatedAt;

  JobRequests(
      {this.id,
      this.jobId,
      this.driverId,
      this.earning,
      this.rating,
      this.jobpercent,
      this.items,
      this.address,
      this.driver,
      this.isApply,
      this.applyAt,
      this.description,
      this.ammount,
      this.status,
      this.createdAt,
      this.updatedAt});

  JobRequests.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobId = json['job_id'];
    driverId = json['driver_id'];
    earning = json['earning'];
    rating = json['rating'];
    jobpercent = json['jobpercent'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(new Address.fromJson(v));
      });
    }
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    isApply = json['is_apply'];
    applyAt = json['apply_at'];
    description = json['description'];
    ammount = json['ammount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['job_id'] = this.jobId;
    data['driver_id'] = this.driverId;
    data['earning'] = this.earning;
    data['rating'] = this.rating;
    data['jobpercent'] = this.jobpercent;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.map((v) => v.toJson()).toList();
    }
    if (this.driver != null) {
      data['driver'] = this.driver!.toJson();
    }
    data['is_apply'] = this.isApply;
    data['apply_at'] = this.applyAt;
    data['description'] = this.description;
    data['ammount'] = this.ammount;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}





// class Links {
//   String? url;
//   String? label;
//   bool? active;

//   Links({this.url, this.label, this.active});

//   Links.fromJson(Map<String, dynamic> json) {
//     url = json['url'];
//     label = json['label'];
//     active = json['active'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['url'] = this.url;
//     data['label'] = this.label;
//     data['active'] = this.active;
//     return data;
//   }
// }
