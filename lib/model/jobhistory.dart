import 'package:click_send/model/jobs.dart';

class JobHistory {
  ViewData? viewData;

  JobHistory({this.viewData});

  JobHistory.fromJson(Map<String, dynamic> json) {
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
  List<Data>? data;
  Links? links;
  Meta? meta;

  ViewData({this.data, this.links, this.meta});

  ViewData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
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
  List<Ratings>? ratings;
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
    acceptBid = json['accept_bid'] != null
        ? AcceptBid.fromJson(json['accept_bid'])
        : null;
    if (json['job_requests'] != null) {
      jobRequests = <JobRequests>[];
      json['job_requests'].forEach((v) {
        jobRequests!.add(JobRequests.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['ratings'] != null) {
      ratings = <Ratings>[];
      json['ratings'].forEach((v) {
        ratings!.add(Ratings.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['created_by'] = createdBy;
    data['name'] = name;
    data['budget'] = budget;
    data['spentmoney'] = spentmoney;
    data['vehical_type'] = vehicalType;
    data['vehicle'] = vehicle;
    data['description'] = description;
    data['status'] = status;
    data['started_on'] = startedOn;
    data['completed_on'] = completedOn;
    data['is_deleted'] = isDeleted;
    data['bid_driver'] = bidDriver;
    data['driver_id'] = driverId;
    data['bid_id'] = bidId;
    if (acceptBid != null) {
      data['accept_bid'] = acceptBid!.toJson();
    }
    if (jobRequests != null) {
      data['job_requests'] = jobRequests!.map((v) => v.toJson()).toList();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (ratings != null) {
      data['ratings'] = ratings!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class AcceptBid {
  int? id;
  int? jobId;
  int? driverId;
  int? earning;
  String? rating;
  String? jobpercent;
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
        items!.add(Items.fromJson(v));
      });
    }
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
    isApply = json['is_apply'];
    applyAt = json['apply_at'];
    description = json['description'];
    ammount = json['ammount'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['driver_id'] = driverId;
    data['earning'] = earning;
    data['rating'] = rating;
    data['jobpercent'] = jobpercent;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    data['is_apply'] = isApply;
    data['apply_at'] = applyAt;
    data['description'] = description;
    data['ammount'] = ammount;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Items {
  Product? product;
  List<Address>? address;

  Items({this.product, this.address});

  Items.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
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
  Null? pickupedAt;
  int? isDrop;
  Null? dropedAt;
  Null? pickupImages;
  Null? dropImages;
  Null? deliveredTo;
  Null? deliveredSign;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['quantity'] = quantity;
    data['material'] = material;
    data['length'] = length;
    data['height'] = height;
    data['width'] = width;
    data['base_url'] = baseUrl;
    data['image'] = image;
    data['pickup_date'] = pickupDate;
    data['pickup_time'] = pickupTime;
    data['drop_date'] = dropDate;
    data['drop_time'] = dropTime;
    data['is_pickup'] = isPickup;
    data['pickuped_at'] = pickupedAt;
    data['is_drop'] = isDrop;
    data['droped_at'] = dropedAt;
    data['pickup_images'] = pickupImages;
    data['drop_images'] = dropImages;
    data['delivered_to'] = deliveredTo;
    data['delivered_sign'] = deliveredSign;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    item = json['item'] != null ? Product.fromJson(json['item']) : null;
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['job_id'] = jobId;
    data['jobitem_id'] = jobitemId;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    data['address'] = address;
    data['lat'] = lat;
    data['long'] = long;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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

class Ratings {
  int? id;
  int? userId;
  Driver? user;
  int? jobId;
  String? givenBy;
  String? review;
  int? rating;
  String? createdAt;
  String? updatedAt;

  Ratings(
      {this.id,
      this.userId,
      this.user,
      this.jobId,
      this.givenBy,
      this.review,
      this.rating,
      this.createdAt,
      this.updatedAt});

  Ratings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    user = json['user'] != null ? Driver.fromJson(json['user']) : null;
    jobId = json['job_id'];
    givenBy = json['given_by'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['job_id'] = jobId;
    data['given_by'] = givenBy;
    data['review'] = review;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  Null? prev;
  Null? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
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
        links!.add(Links.fromJson(v));
      });
    }
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
