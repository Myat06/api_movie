import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/models/model.dart';

const apiKey = "6af7ed624a9b4f9502ebc17b4e86b03f";

class apiService {
  final nowShowingApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";

  final upCommingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";

  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";

  //for nowShowing movie
  Future<List<Movie>> getNowShowing() async {
    Uri url = Uri.parse(nowShowingApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

  //for up comming movies
  Future<List<Movie>> getUpComming() async {
    Uri url = Uri.parse(upCommingApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }

  //for pupular movies
  Future<List<Movie>> getPopular() async {
    Uri url = Uri.parse(popularApi);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to load data");
    }
  }
}
