class Invoice {
  ViewData? viewData;

  Invoice({this.viewData});

  Invoice.fromJson(Map<String, dynamic> json) {
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
  String? invoiceNumber;
  int? jobId;
  Job? job;
  int? billedBy;
  BilledByUser? billedByUser;
  int? billedTo;
  dynamic billedToUser;
  String? baseUrl;
  String? signImage;
  Null amount;
  Null comments;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.invoiceNumber,
      this.jobId,
      this.job,
      this.billedBy,
      this.billedByUser,
      this.billedTo,
      this.billedToUser,
      this.baseUrl,
      this.signImage,
      this.amount,
      this.comments,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    jobId = json['job_id'];
    job = json['job'] != null ? Job.fromJson(json['job']) : null;
    billedBy = json['billed_by'];
    billedByUser = json['billed_by_user'] != null
        ? BilledByUser.fromJson(json['billed_by_user'])
        : null;
    billedTo = json['billed_to'];
    billedToUser = json['billed_to_user'];
    baseUrl = json['base_url'];
    signImage = json['sign_image'];
    amount = json['amount'];
    comments = json['comments'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['invoice_number'] = invoiceNumber;
    data['job_id'] = jobId;
    if (job != null) {
      data['job'] = job!.toJson();
    }
    data['billed_by'] = billedBy;
    if (billedByUser != null) {
      data['billed_by_user'] = billedByUser!.toJson();
    }
    data['billed_to'] = billedTo;
    data['billed_to_user'] = billedToUser;
    data['base_url'] = baseUrl;
    data['sign_image'] = signImage;
    data['amount'] = amount;
    data['comments'] = comments;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  Null startedOn;
  Null completedOn;
  int? isDeleted;
  Null reason;
  Null sendInvoice;
  String? createdAt;
  String? updatedAt;

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
      this.sendInvoice,
      this.createdAt,
      this.updatedAt});

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
    sendInvoice = json['send_invoice'];
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
    data['vehical_type'] = vehicalType;
    data['vehicle'] = vehicle;
    data['description'] = description;
    data['status'] = status;
    data['started_on'] = startedOn;
    data['completed_on'] = completedOn;
    data['is_deleted'] = isDeleted;
    data['reason'] = reason;
    data['send_invoice'] = sendInvoice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BilledByUser {
  int? id;
  String? userType;
  String? dialCode;
  String? email;
  String? mobile;
  Null emailVerifiedAt;
  String? term;
  int? status;
  Null socialType;
  Null appToken;
  Null webToken;
  Null stripConnectId;
  Null stripCustomerId;
  String? createdAt;
  String? updatedAt;

  BilledByUser(
      {this.id,
      this.userType,
      this.dialCode,
      this.email,
      this.mobile,
      this.emailVerifiedAt,
      this.term,
      this.status,
      this.socialType,
      this.appToken,
      this.webToken,
      this.stripConnectId,
      this.stripCustomerId,
      this.createdAt,
      this.updatedAt});

  BilledByUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    dialCode = json['dial_code'];
    email = json['email'];
    mobile = json['mobile'];
    emailVerifiedAt = json['email_verified_at'];
    term = json['term'];
    status = json['status'];
    socialType = json['social_type'];
    appToken = json['app_token'];
    webToken = json['web_token'];
    stripConnectId = json['strip_connect_id'];
    stripCustomerId = json['strip_customer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['dial_code'] = dialCode;
    data['email'] = email;
    data['mobile'] = mobile;
    data['email_verified_at'] = emailVerifiedAt;
    data['term'] = term;
    data['status'] = status;
    data['social_type'] = socialType;
    data['app_token'] = appToken;
    data['web_token'] = webToken;
    data['strip_connect_id'] = stripConnectId;
    data['strip_customer_id'] = stripCustomerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  Null prev;
  Null next;

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
