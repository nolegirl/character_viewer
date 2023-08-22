class Character {
  String? firstURL;
  String? iconURL;
  String? text;

  Character({
    this.firstURL,
    this.iconURL,
    this.text
});

  Character.fromJson(Map<String, dynamic> json) {
    firstURL = json['FirstURL'];
    iconURL = json['Icon']['URL'];
    text = json['Text'];
  }

  //TODO: Set up pulling name from FirstURL or Text
}