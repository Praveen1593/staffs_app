import 'dart:convert';

NewsCircularModel newsCircularModelFromJson(String str) =>
    NewsCircularModel.fromJson(json.decode(str));

String newsCircularModelToJson(NewsCircularModel data) =>
    json.encode(data.toJson());

class NewsCircularModel {
  NewsCircularModel({
    required this.newsData,
    required this.links,
    required this.meta,
    this.code,
    required this.status,
    required this.msg,
  });

  List<NewModel> newsData;
  Links links;
  Meta meta;
  int? code;
  String status;
  String msg;

  factory NewsCircularModel.fromJson(Map<String, dynamic> json) =>
      NewsCircularModel(
        newsData: List<NewModel>.from(json["data"].map((x) => NewModel.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
        code: json["code"],
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(newsData.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
        "code": code,
        "status": status,
        "msg": msg,
      };
}

class NewModel {
  NewModel({
    this.id,
    this.uuid,
    this.date,
    this.title,
    this.description,
    this.images,
    this.type,
    this.scheduleType,
    this.sendType,
    this.sendTypeName,
    this.status,
  });

  int? id;
  String? uuid;
  String? date;
  String? title;
  String? description;
  List<Image>? images;
  int? type;
  int? scheduleType;
  int? sendType;
  String? sendTypeName;
  int? status;

  factory NewModel.fromJson(Map<String, dynamic> json) => NewModel(
        id: json["id"],
        uuid: json["uuid"],
        date: json["date"],
        title: json["title"],
        description: json["description"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        type: json["type"],
        scheduleType: json["schedule_type"],
        sendType: json["send_type"],
        sendTypeName: json["send_type_name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "date": date,
        "title": title,
        "description": description,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "type": type,
        "schedule_type": scheduleType,
        "send_type": sendType,
        "send_type_name": sendTypeName,
        "status": status,
      };
}

class Image {
  Image({
    this.id,
    this.file,
    this.oldFile,
    this.oldAttachFile,
    this.attachType,
  });

  int? id;
  String? file;
  String? oldFile;
  String? oldAttachFile;
  String? attachType;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        file: json["file"],
        oldFile: json["old_file"],
        oldAttachFile: json["old_attach_file"],
        attachType: json["attach_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "old_file": oldFile,
        "old_attach_file": oldAttachFile,
        "attach_type": attachType,
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}
