import 'package:json_annotation/json_annotation.dart';

part 'qq_song_list.g.dart';

@JsonSerializable()
class QqSongList {
  @JsonKey(defaultValue: 0)
  final int code;
  @JsonKey(defaultValue: '')
  final String msg;
  final Data? data;

  QqSongList({
    required this.code,
    required this.msg,
    this.data,
  });

  factory QqSongList.fromJson(Map<String, dynamic> json) =>
      _$QqSongListFromJson(json);

  Map<String, dynamic> toJson() => _$QqSongListToJson(this);
}

@JsonSerializable()
class Data {
  final Info? info;
  @JsonKey(defaultValue: [])
  final List<ListDataBean> list;

  Data({
    this.info,
    required this.list,
  });

  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Info {
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String picurl;
  @JsonKey(defaultValue: 0)
  final int songnum;
  @JsonKey(defaultValue: '')
  final String headurl;

  Info({
    required this.title,
    required this.picurl,
    required this.songnum,
    required this.headurl,
  });

  factory Info.fromJson(Map<String, dynamic> json) =>
      _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class ListDataBean {
  @JsonKey(defaultValue: '')
  final String mid;
  @JsonKey(defaultValue: '')
  final String vid;
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String author;
  @JsonKey(defaultValue: '')
  final String pic;
  final Album? album;

  ListDataBean({
    required this.mid,
    required this.vid,
    required this.title,
    required this.author,
    required this.pic,
    this.album,
  });

  factory ListDataBean.fromJson(Map<String, dynamic> json) =>
      _$ListDataBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ListDataBeanToJson(this);
}

@JsonSerializable()
class Album {
  @JsonKey(defaultValue: '')
  final String name;
  @JsonKey(defaultValue: '')
  final String title;

  Album({
    required this.name,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) =>
      _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
