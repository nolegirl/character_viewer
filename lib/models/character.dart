import 'dart:io';

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
    } else {
      if (Platform.isAndroid) {
        iconURL = 'https://1.bp.blogspot.com/-GnLvST4e76I/U-egLS76FpI/AAAAAAAADPI/pZ1vfb33B-c/s1600/Logo+The_Simpsons.png';
      } else if (Platform.isIOS) {
        iconURL = 'http://payload29.cargocollective.com/1/1/39953/2890237/The-Wire-Birds-Logo-Version_o_960.jpg';
      }
    }
  }

  //TODO: Set up pulling name from FirstURL or Text
}