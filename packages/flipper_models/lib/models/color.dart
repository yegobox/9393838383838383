// To parse this JSON data, do
//
//     final pColor = pColorFromJson(jsonString);

import 'dart:convert';

List<PColor> pColorFromJson(String str) =>
    List<PColor>.from(json.decode(str).map((x) => PColor.fromJson(x)));

String pColorToJson(List<PColor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PColor {
  PColor({
    this.id,
    this.name,
    required this.channels,
    this.colors,
    this.table,
    required this.branchId,
    required this.active,
  });

  String? id;
  String? name;
  List<String> channels;
  List<String>? colors;
  String? table;
  String branchId;
  bool active;

  factory PColor.fromJson(Map<String, dynamic> json) => PColor(
        id: json["id"],
        name: json["name"],
        channels: List<String>.from(json["channels"].map((x) => x)),
        colors: List<String>.from(json["colors"].map((x) => x)),
        table: json["table"],
        branchId: json["branchId"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "channels": List<dynamic>.from(channels.map((x) => x)),
        "colors": List<dynamic>.from(colors!.map((x) => x)),
        "table": table,
        "branchId": branchId,
        "active": active,
      };
}
