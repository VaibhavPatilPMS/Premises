// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_object_api_and_request_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommonFileObjectApiAndRequestModelAdapter
    extends TypeAdapter<CommonFileObjectApiAndRequestModel> {
  @override
  final typeId = 73;

  @override
  CommonFileObjectApiAndRequestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommonFileObjectApiAndRequestModel(
      fieldname: fields[0] as String?,
      originalname: fields[1] as String?,
      encoding: fields[2] as String?,
      mimetype: fields[3] as String?,
      destination: fields[4] as String?,
      filename: fields[5] as String?,
      path: fields[6] as String?,
      size: fields[7] as dynamic,
      imageStaticURL: fields[8] as String?,
      customProfilePath: fields[9] as String?,
      customPath: fields[10] as String?,
      fileUrlToOpen: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CommonFileObjectApiAndRequestModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.fieldname)
      ..writeByte(1)
      ..write(obj.originalname)
      ..writeByte(2)
      ..write(obj.encoding)
      ..writeByte(3)
      ..write(obj.mimetype)
      ..writeByte(4)
      ..write(obj.destination)
      ..writeByte(5)
      ..write(obj.filename)
      ..writeByte(6)
      ..write(obj.path)
      ..writeByte(7)
      ..write(obj.size)
      ..writeByte(8)
      ..write(obj.imageStaticURL)
      ..writeByte(9)
      ..write(obj.customProfilePath)
      ..writeByte(10)
      ..write(obj.customPath)
      ..writeByte(11)
      ..write(obj.fileUrlToOpen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommonFileObjectApiAndRequestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonFileObjectApiAndRequestModel _$CommonFileObjectApiAndRequestModelFromJson(
  Map<String, dynamic> json,
) => CommonFileObjectApiAndRequestModel(
  fieldname: json['fieldname'] as String?,
  originalname: json['originalname'] as String?,
  encoding: json['encoding'] as String?,
  mimetype: json['mimetype'] as String?,
  destination: json['destination'] as String?,
  filename: json['filename'] as String?,
  path: json['path'] as String?,
  size: json['size'],
  imageStaticURL: json['imageStaticURL'] as String?,
  customProfilePath: json['customProfilePath'] as String?,
  customPath: json['customPath'] as String?,
  fileUrlToOpen: json['downloadUrl'] as String?,
  fileName: json['fileName'] as String?,
  baseUrl: json['baseUrl'] as String?,
  filepath: json['filepath'] as String?,
);

Map<String, dynamic> _$CommonFileObjectApiAndRequestModelToJson(
  CommonFileObjectApiAndRequestModel instance,
) => <String, dynamic>{
  'fieldname': ?instance.fieldname,
  'originalname': ?instance.originalname,
  'encoding': ?instance.encoding,
  'mimetype': ?instance.mimetype,
  'destination': ?instance.destination,
  'filename': ?instance.filename,
  'path': ?instance.path,
  'size': ?instance.size,
  'fileName': ?instance.fileName,
};
