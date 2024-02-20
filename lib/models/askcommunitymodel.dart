import 'dart:convert';

List<AskTheCommunityModels> askTheCommunityModelsFromJson(String str) =>
    List<AskTheCommunityModels>.from(
        json.decode(str).map((x) => AskTheCommunityModels.fromJson(x)));

String askTheCommunityModelsToJson(List<AskTheCommunityModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AskTheCommunityModels {
  String id;
  String businessUid;
  List<Datum> data;

  AskTheCommunityModels({
    required this.id,
    required this.businessUid,
    required this.data,
  });

  factory AskTheCommunityModels.fromJson(Map<String, dynamic> json) =>
      AskTheCommunityModels(
        id: json["_id"],
        businessUid: json["business_uid"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "business_uid": businessUid,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  List<Answer> answers;
  Qdetails qdetails;
  String question;

  Datum({
    required this.answers,
    required this.qdetails,
    required this.question,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        answers:
            List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
        qdetails: Qdetails.fromJson(json["qdetails"]),
        question: json["question"],
      );

  Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
        "qdetails": qdetails.toJson(),
        "question": question,
      };
}

class Answer {
  Adetails adetails;
  String? answer;

  Answer({
    required this.adetails,
    this.answer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        adetails: Adetails.fromJson(json["adetails"]),
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "adetails": adetails.toJson(),
        "answer": answer,
      };
}

class Adetails {
  String createdAt;
  String userid;
  String? answerid;
  dynamic updatedAt;

  Adetails({
    required this.createdAt,
    required this.userid,
    this.answerid,
    this.updatedAt,
  });

  factory Adetails.fromJson(Map<String, dynamic> json) => Adetails(
        createdAt: json["created_at"],
        userid: json["userid"],
        answerid: json["answerid"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "userid": userid,
        "answerid": answerid,
        "updated_at": updatedAt,
      };
}

class Qdetails {
  String createdAt;
  String questionid;
  String userid;
  DateTime? updatedAt;

  Qdetails({
    required this.createdAt,
    required this.questionid,
    required this.userid,
    this.updatedAt,
  });

  factory Qdetails.fromJson(Map<String, dynamic> json) => Qdetails(
        createdAt: json["created_at"],
        questionid: json["questionid"],
        userid: json["userid"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "questionid": questionid,
        "userid": userid,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
