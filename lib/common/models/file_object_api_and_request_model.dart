import 'package:hive_ce/hive_ce.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_object_api_and_request_model.g.dart';

@HiveType(typeId: 73)
@JsonSerializable(explicitToJson: true)
class CommonFileObjectApiAndRequestModel {
  @HiveField(0)
  @JsonKey(includeIfNull: false)
  String? fieldname;
  @HiveField(1)
  @JsonKey(includeIfNull: false)
  String? originalname;
  @HiveField(2)
  @JsonKey(includeIfNull: false)
  String? encoding;
  @HiveField(3)
  @JsonKey(includeIfNull: false)
  String? mimetype;
  @HiveField(4)
  @JsonKey(includeIfNull: false)
  String? destination;
  @HiveField(5)
  @JsonKey(includeIfNull: false)
  String? filename;
  @HiveField(6)
  @JsonKey(includeIfNull: false)
  String? path;
  @HiveField(7)
  @JsonKey(includeIfNull: false)
  dynamic size;
  @HiveField(8)
  @JsonKey(includeToJson: false, includeIfNull: false)
  String? imageStaticURL;
  @HiveField(9)
  @JsonKey(includeToJson: false, includeIfNull: false)
  String? customProfilePath;
  @HiveField(10)
  @JsonKey(includeToJson: false, includeIfNull: false)
  String? customPath;
  @HiveField(11)
  @JsonKey(
    name: 'downloadUrl',
    includeToJson: false,
    includeIfNull: false,
  )
  String? fileUrlToOpen;
  @JsonKey(includeIfNull: false)
  String? fileName;
  @JsonKey(includeToJson: false, includeIfNull: false)
  String? baseUrl;
  @JsonKey(includeToJson: false, includeIfNull: false)
  String? filepath;

  CommonFileObjectApiAndRequestModel({
    this.fieldname,
    this.originalname,
    this.encoding,
    this.mimetype,
    this.destination,
    this.filename,
    this.path,
    this.size,
    this.imageStaticURL,
    this.customProfilePath,
    this.customPath,
    this.fileUrlToOpen,
    this.fileName,
    this.baseUrl,
    this.filepath,
  });

  factory CommonFileObjectApiAndRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$CommonFileObjectApiAndRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CommonFileObjectApiAndRequestModelToJson(this);
}
