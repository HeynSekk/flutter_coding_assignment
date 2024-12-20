// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Post',
      json,
      ($checkedConvert) {
        final val = Post(
          userId: $checkedConvert('user_id', (v) => (v as num?)?.toInt()),
          id: $checkedConvert('id', (v) => (v as num?)?.toInt()),
          title: $checkedConvert('title', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'userId': 'user_id'},
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'user_id': instance.userId,
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
    };
