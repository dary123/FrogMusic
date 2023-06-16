// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qq_song_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QqSongList _$QqSongListFromJson(Map<String, dynamic> json) => QqSongList(
      code: json['code'] as int? ?? 0,
      msg: json['msg'] as String? ?? '',
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QqSongListToJson(QqSongList instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => ListDataBean.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'info': instance.info,
      'list': instance.list,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      title: json['title'] as String? ?? '',
      picurl: json['picurl'] as String? ?? '',
      songnum: json['songnum'] as int? ?? 0,
      headurl: json['headurl'] as String? ?? '',
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'title': instance.title,
      'picurl': instance.picurl,
      'songnum': instance.songnum,
      'headurl': instance.headurl,
    };

ListDataBean _$ListDataBeanFromJson(Map<String, dynamic> json) => ListDataBean(
      mid: json['mid'] as String? ?? '',
      vid: json['vid'] as String? ?? '',
      title: json['title'] as String? ?? '',
      author: json['author'] as String? ?? '',
      pic: json['pic'] as String? ?? '',
      album: json['album'] == null
          ? null
          : Album.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListDataBeanToJson(ListDataBean instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'vid': instance.vid,
      'title': instance.title,
      'author': instance.author,
      'pic': instance.pic,
      'album': instance.album,
    };

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      name: json['name'] as String? ?? '',
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'name': instance.name,
      'title': instance.title,
    };
