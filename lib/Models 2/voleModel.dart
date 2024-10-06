class FlightModel {
  List<FlightData> data;

  FlightModel({
    required this.data,
  });

  factory FlightModel.fromJson(List<dynamic> json) => FlightModel(
        data: List<FlightData>.from(json.map((x) => FlightData.fromJson(x))),
      );

  List<dynamic> toJson() => List<dynamic>.from(data.map((x) => x.toJson()));
}

class FlightData {
  String id;
  String from;
  String to;
  String date;
  String time;
  String deptime;
  String arrtime;
  int version;

  FlightData({
    required this.id,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.deptime,
    required this.arrtime,
    required this.version,
  });

  factory FlightData.fromJson(Map<String, dynamic> json) => FlightData(
        id: json["_id"],
        from: json["fm"],
        to: json["to"],
        date: json["date"],
        time: json["time"],
        deptime: json["deptime"],
        arrtime: json["arrtime"],
        version: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fm": from,
        "to": to,
        "date": date,
        "time": time,
        "deptime": deptime,
        "arrtime": arrtime,
        "__v": version,
      };
}
