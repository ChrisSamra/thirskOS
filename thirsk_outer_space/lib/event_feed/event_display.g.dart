// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_display.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnePostData _$OnePostDataFromJson(Map<String, dynamic> json) {
  return OnePostData(
      postId: json['Post_id'] as String,
      name: json['name'] as String,
      uid: json['uid'] as String,
      title: json['title'] as String,
      postContent: json['content'] as String,
      postDate: json['postDate'] as String);
}

Map<String, dynamic> _$OnePostDataToJson(OnePostData instance) =>
    <String, dynamic>{
      'Post_id': instance.postId,
      'name': instance.name,
      'uid': instance.uid,
      'title': instance.title,
      'content': instance.postContent,
      'postDate': instance.postDate
    };
