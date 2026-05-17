// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_api_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendingTasksApiModelAdapter extends TypeAdapter<PendingTasksApiModel> {
  @override
  final typeId = 143;

  @override
  PendingTasksApiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingTasksApiModel(
      total: (fields[0] as num?)?.toInt(),
      limit: (fields[1] as num?)?.toInt(),
      skip: (fields[2] as num?)?.toInt(),
      data: (fields[3] as List?)?.cast<PendingTasksDataApiModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PendingTasksApiModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.limit)
      ..writeByte(2)
      ..write(obj.skip)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingTasksApiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PendingTasksDataApiModelAdapter
    extends TypeAdapter<PendingTasksDataApiModel> {
  @override
  final typeId = 144;

  @override
  PendingTasksDataApiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingTasksDataApiModel(
      dashboardCarouselPendingCounts: (fields[0] as List?)
          ?.cast<DashboardCarouselPendingCountsApiModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, PendingTasksDataApiModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.dashboardCarouselPendingCounts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingTasksDataApiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DashboardCarouselPendingCountsApiModelAdapter
    extends TypeAdapter<DashboardCarouselPendingCountsApiModel> {
  @override
  final typeId = 145;

  @override
  DashboardCarouselPendingCountsApiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardCarouselPendingCountsApiModel(
      module: fields[0] as String?,
      totalPendingCount: (fields[1] as num?)?.toInt(),
      pendingCounts: fields[2] as PendingCountsApiModel?,
    );
  }

  @override
  void write(BinaryWriter writer, DashboardCarouselPendingCountsApiModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.module)
      ..writeByte(1)
      ..write(obj.totalPendingCount)
      ..writeByte(2)
      ..write(obj.pendingCounts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardCarouselPendingCountsApiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PendingCountsApiModelAdapter extends TypeAdapter<PendingCountsApiModel> {
  @override
  final typeId = 146;

  @override
  PendingCountsApiModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PendingCountsApiModel(
      reviewerPendingCount: (fields[0] as num?)?.toInt(),
      makerPendingCount: (fields[1] as num?)?.toInt(),
      auditorPendingCount: (fields[2] as num?)?.toInt(),
      checkerPendingCount: (fields[3] as num?)?.toInt(),
      myChecklistPendingCount: (fields[4] as num?)?.toInt(),
      byMePendingCount: (fields[5] as num?)?.toInt(),
      forMePendingCount: (fields[6] as num?)?.toInt(),
      approverPendingCount: (fields[7] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, PendingCountsApiModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.reviewerPendingCount)
      ..writeByte(1)
      ..write(obj.makerPendingCount)
      ..writeByte(2)
      ..write(obj.auditorPendingCount)
      ..writeByte(3)
      ..write(obj.checkerPendingCount)
      ..writeByte(4)
      ..write(obj.myChecklistPendingCount)
      ..writeByte(5)
      ..write(obj.byMePendingCount)
      ..writeByte(6)
      ..write(obj.forMePendingCount)
      ..writeByte(7)
      ..write(obj.approverPendingCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendingCountsApiModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectImageApiModel _$ProjectImageApiModelFromJson(
  Map<String, dynamic> json,
) => ProjectImageApiModel(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ProjectImageApiDataModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ProjectImageApiModelToJson(
  ProjectImageApiModel instance,
) => <String, dynamic>{'data': instance.data};

ProjectImageApiDataModel _$ProjectImageApiDataModelFromJson(
  Map<String, dynamic> json,
) => ProjectImageApiDataModel(
  sId: json['sId'] as String?,
  photo: json['photo'],
  isPlanExpired: json['isPlanExpired'] as bool?,
);

Map<String, dynamic> _$ProjectImageApiDataModelToJson(
  ProjectImageApiDataModel instance,
) => <String, dynamic>{
  'sId': instance.sId,
  'photo': instance.photo,
  'isPlanExpired': instance.isPlanExpired,
};

PendingTasksApiModel _$PendingTasksApiModelFromJson(
  Map<String, dynamic> json,
) => PendingTasksApiModel(
  total: (json['total'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  skip: (json['skip'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PendingTasksDataApiModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PendingTasksApiModelToJson(
  PendingTasksApiModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'limit': instance.limit,
  'skip': instance.skip,
  'data': instance.data,
};

PendingTasksDataApiModel _$PendingTasksDataApiModelFromJson(
  Map<String, dynamic> json,
) => PendingTasksDataApiModel(
  dashboardCarouselPendingCounts:
      (json['dashboardCarouselPendingCounts'] as List<dynamic>?)
          ?.map(
            (e) => DashboardCarouselPendingCountsApiModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
);

Map<String, dynamic> _$PendingTasksDataApiModelToJson(
  PendingTasksDataApiModel instance,
) => <String, dynamic>{
  'dashboardCarouselPendingCounts': instance.dashboardCarouselPendingCounts,
};

DashboardCarouselPendingCountsApiModel
_$DashboardCarouselPendingCountsApiModelFromJson(Map<String, dynamic> json) =>
    DashboardCarouselPendingCountsApiModel(
      module: json['module'] as String?,
      totalPendingCount: (json['totalPendingCount'] as num?)?.toInt(),
      pendingCounts: json['pendingCounts'] == null
          ? null
          : PendingCountsApiModel.fromJson(
              json['pendingCounts'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$DashboardCarouselPendingCountsApiModelToJson(
  DashboardCarouselPendingCountsApiModel instance,
) => <String, dynamic>{
  'module': instance.module,
  'totalPendingCount': instance.totalPendingCount,
  'pendingCounts': instance.pendingCounts,
};

PendingCountsApiModel _$PendingCountsApiModelFromJson(
  Map<String, dynamic> json,
) => PendingCountsApiModel(
  reviewerPendingCount: (json['reviewerPendingCount'] as num?)?.toInt(),
  makerPendingCount: (json['makerPendingCount'] as num?)?.toInt(),
  auditorPendingCount: (json['auditorPendingCount'] as num?)?.toInt(),
  checkerPendingCount: (json['checkerPendingCount'] as num?)?.toInt(),
  myChecklistPendingCount: (json['myChecklistPendingCount'] as num?)?.toInt(),
  byMePendingCount: (json['byMePendingCount'] as num?)?.toInt(),
  forMePendingCount: (json['forMePendingCount'] as num?)?.toInt(),
  approverPendingCount: (json['approverPendingCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$PendingCountsApiModelToJson(
  PendingCountsApiModel instance,
) => <String, dynamic>{
  'reviewerPendingCount': instance.reviewerPendingCount,
  'makerPendingCount': instance.makerPendingCount,
  'auditorPendingCount': instance.auditorPendingCount,
  'checkerPendingCount': instance.checkerPendingCount,
  'myChecklistPendingCount': instance.myChecklistPendingCount,
  'byMePendingCount': instance.byMePendingCount,
  'forMePendingCount': instance.forMePendingCount,
  'approverPendingCount': instance.approverPendingCount,
};

CommonApiResponseModel _$CommonApiResponseModelFromJson(
  Map<String, dynamic> json,
) => CommonApiResponseModel(
  message: json['message'] as String?,
  code: json['code'] as String?,
  sId: json['id'] as String?,
  customStatusCode: (json['statusCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$CommonApiResponseModelToJson(
  CommonApiResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'code': instance.code,
  'id': instance.sId,
  'statusCode': instance.customStatusCode,
};
