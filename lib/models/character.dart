class Character {
  String? firstURL;
  String? iconURL;
  String? text;
  String? name;

  Character({
    this.firstURL,
    this.iconURL,
    this.text
});

  Character.fromJson(Map<String, dynamic> json) {
    firstURL = json['FirstURL'];
    iconURL = json['Icon']['URL'];
    text = json['Text'];
    name = text?.split('-')[0];

    if (iconURL != '') {
      iconURL = 'https://duckduckgo.com/${iconURL}';
    }
  }

  //TODO: Set up pulling name from FirstURL or Text
}