// To parse this JSON data, do
//
//     final searchCustomerModel = searchCustomerModelFromJson(jsonString);

import 'dart:convert';

SearchCustomerModel searchCustomerModelFromJson(String str) => SearchCustomerModel.fromJson(json.decode(str));

String searchCustomerModelToJson(SearchCustomerModel data) => json.encode(data.toJson());

class SearchCustomerModel {
    int? errorCode;
    List<Datum>? data;
    String? message;

    SearchCustomerModel({
        this.errorCode,
        this.data,
        this.message,
    });

    factory SearchCustomerModel.fromJson(Map<String, dynamic> json) => SearchCustomerModel(
        errorCode: json["error_code"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class Datum {
    int? id;
    String? name;
    String? profilePic;
    String? mobileNumber;
    String? email;
    String? street;
    String? streetTwo;
    String? city;
    int? pincode;
    String? country;
    String? state;
    DateTime? createdDate;
    String? createdTime;
    DateTime? modifiedDate;
    String? modifiedTime;
    bool? flag;

    Datum({
        this.id,
        this.name,
        this.profilePic,
        this.mobileNumber,
        this.email,
        this.street,
        this.streetTwo,
        this.city,
        this.pincode,
        this.country,
        this.state,
        this.createdDate,
        this.createdTime,
        this.modifiedDate,
        this.modifiedTime,
        this.flag,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        profilePic: json["profile_pic"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        street: json["street"],
        streetTwo: json["street_two"],
        city: json["city"],
        pincode: json["pincode"],
        country: json["country"],
        state: json["state"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: json["modified_date"] == null ? null : DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_pic": profilePic,
        "mobile_number": mobileNumber,
        "email": email,
        "street": street,
        "street_two": streetTwo,
        "city": city,
        "pincode": pincode,
        "country": country,
        "state": state,
        "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date": "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
    };
}
