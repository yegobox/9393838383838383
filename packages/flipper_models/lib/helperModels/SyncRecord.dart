library flipper_models;

import 'package:flipper_models/sync_service.dart';

import 'package:json_annotation/json_annotation.dart';
part 'SyncRecord.g.dart';

/// this model will help us know the model that was pushed to the server
/// so that we don't try to push them unless they have update
@JsonSerializable()
class SyncRecord extends IJsonSerializable {
  int? id;
  String modelId;
  DateTime createdAt;
  int branchId;

  SyncRecord(
      {required this.id,
      required this.modelId,
      required this.createdAt,
      required this.branchId});
  factory SyncRecord.fromJson(Map<String, dynamic> json) =>
      _$SyncRecordFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$SyncRecordToJson(this);
}
