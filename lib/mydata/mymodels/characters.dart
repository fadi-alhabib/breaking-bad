class Charachter {
  late int charId;
  late String name;
  late String nickName;
  late String image;
  late List<dynamic> jobs;
  late String livingStatus;
  late List<dynamic> appearanceOfSeasons;
  late String actorName;
  late String categoryForSeries;
  late List<dynamic> betterCallSaulAppearance;

  Charachter.fromJson(Map<String, dynamic> json) {
    charId = json["char_id"];
    name = json["name"];
    nickName = json["nickname"];
    image = json["img"];
    jobs = json["occupation"];
    livingStatus = json["status"];
    appearanceOfSeasons = json["appearance"];
    actorName = json["portrayed"];
    categoryForSeries = json["category"];
    betterCallSaulAppearance = json["better_call_saul_appearance"];
  }
}
