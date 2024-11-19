class TeamModel {
  String? name;
  String? country;
  String? badgeUrl;

  TeamModel({
    this.name,
    this.country,
    this.badgeUrl,
  });


  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      name: json['strTeam'],
      country: json['strCountry'],
      badgeUrl: json['strBadge'],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'badgeUrl': badgeUrl,
    };
  }

  @override
  String toString() {
    return 'TeamModel{name: $name, country: $country, badgeUrl: $badgeUrl}';
  }
}