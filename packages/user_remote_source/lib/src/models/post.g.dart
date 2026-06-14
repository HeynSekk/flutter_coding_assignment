// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Post',
      json,
      ($checkedConvert) {
        final val = PostModel(
          userId: $checkedConvert('userId', (v) => (v as num?)?.toInt()),
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          title: $checkedConvert('title', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PostToJson(PostModel instance) => <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
