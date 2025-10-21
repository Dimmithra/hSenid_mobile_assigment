class CountryDetailsModel {
  Data? data;

  CountryDetailsModel({this.data});

  CountryDetailsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Countries>? countries;

  Data({this.countries});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  String? code;
  String? emoji;
  String? capital;
  String? currency;
  Continent? continent;
  List<Languages>? languages;
  String? name;

  Countries(
      {this.code,
      this.emoji,
      this.capital,
      this.currency,
      this.continent,
      this.languages,
      this.name});

  Countries.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    emoji = json['emoji'];
    capital = json['capital'];
    currency = json['currency'];
    continent = json['continent'] != null
        ? new Continent.fromJson(json['continent'])
        : null;
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['emoji'] = this.emoji;
    data['capital'] = this.capital;
    data['currency'] = this.currency;
    if (this.continent != null) {
      data['continent'] = this.continent!.toJson();
    }
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    return data;
  }
}

class Continent {
  String? name;
  String? code;

  Continent({this.name, this.code});

  Continent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

// languages
class Languages {
  String? name;
  String? code;

  Languages({this.name, this.code});

  Languages.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
