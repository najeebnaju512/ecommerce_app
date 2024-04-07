// To parse this JSON data, do
//
//     final singleProductModel = singleProductModelFromJson(jsonString);

import 'dart:convert';

SingleProductModel singleProductModelFromJson(String str) => SingleProductModel.fromJson(json.decode(str));

String singleProductModelToJson(SingleProductModel data) => json.encode(data.toJson());

class SingleProductModel {
    int? errorCode;
    Data? data;
    String? message;

    SingleProductModel({
        this.errorCode,
        this.data,
        this.message,
    });

    factory SingleProductModel.fromJson(Map<String, dynamic> json) => SingleProductModel(
        errorCode: json["error_code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": data?.toJson(),
        "message": message,
    };
}

class Data {
    int? id;
    String? name;
    String? image;
    int? price;
    DateTime? createdDate;
    String? createdTime;
    DateTime? modifiedDate;
    String? modifiedTime;
    bool? flag;

    Data({
        this.id,
        this.name,
        this.image,
        this.price,
        this.createdDate,
        this.createdTime,
        this.modifiedDate,
        this.modifiedTime,
        this.flag,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: json["modified_date"] == null ? null : DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date": "${modifiedDate!.year.toString().padLeft(4, '0')}-${modifiedDate!.month.toString().padLeft(2, '0')}-${modifiedDate!.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
    };
}
