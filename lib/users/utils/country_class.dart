import 'package:http/http.dart' as http;
import 'dart:convert';

class Country {
  final String name;
  final String? flag;
  final String region;

  Country({required this.name, required this.flag, required this.region});

  static Country fromJson(Map<String, dynamic> json) => Country(
        name: json['name']['common'],
        flag: json['flag'],
        region: json['region'],
      );
}

class CountryList {
  static Future<List<Country>> getCountries() async {
    final url = Uri.parse('https://restcountries.com/v3.1/all');

    final response = await http.get(url);
    final List countries =
        json.decode(Utf8Decoder().convert(response.bodyBytes));
    // countries.sort(((a, b) => a.name.compareTo(b.name)));
    countries
        .sort(((a, b) => a['name']['common'].compareTo(b['name']['common'])));

    return countries.map((json) => Country.fromJson(json)).toList();
  }
}
