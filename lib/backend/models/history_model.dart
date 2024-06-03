class HistoryModel {
  bool? success;
  String? message;
  int? count;
  String? next;
  Null? previous;
  List<Data>? data;

  HistoryModel(
      {this.success,
        this.message,
        this.count,
        this.next,
        this.previous,
        this.data});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? uuid;
  double? price;
  String? createdAt;
  String? updatedAt;
  String? status;
  Event? event;
  User? user;

  Data(
      {this.uuid,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.event,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Event {
  String? uuid;
  String? name;
  String? club;

  Event({this.uuid, this.name, this.club});

  Event.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    club = json['club'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['club'] = this.club;
    return data;
  }
}

class User {
  String? uuid;
  String? name;
  String? email;
  String? profilePicture;

  User({this.uuid, this.name, this.email, this.profilePicture});

  User.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    email = json['email'];
    profilePicture = json['profile_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_picture'] = this.profilePicture;
    return data;
  }
}