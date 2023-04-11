import 'dart:convert';
import 'dart:developer';

import 'package:bt_c3/movie_finder/model/movie.dart';
import 'package:bt_c3/movie_finder/model/movie_api_response.dart';
import 'package:bt_c3/movie_finder/model/movie_cast_api_response.dart';
import 'package:bt_c3/movie_finder/model/movie_primary_info_api_response.dart';
import 'package:bt_c3/movie_finder/movie_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class MovieFinderProvider extends ChangeNotifier {
  MovieApiResponse? movieApiResult;
  MovieCastApiResponse? movieCastApiResult;
  MoviePrimaryInfoApiResponse? moviePrimaryInfoApiResult;
  var isMovieApiLoaded = false;
  var isMovieCastLoaded = false;
  var isMoviePrimaryInfoLoaded = false;

  void loadCast(Movie movie) async {
    log("Loading cast");
    try {
      Future<MoviePrimaryInfoApiResponse?> moviePrimaryInfoApiResponse =
          Future(() async {
        final response = await http.get(Uri.parse(
            "https://api.themoviedb.org/3/movie/${movie.id}?api_key=${MovieFinderConstants.apiKey}&language=en-US"));
        if (response.statusCode == 200) {
          return MoviePrimaryInfoApiResponse.fromJson(
              jsonDecode(response.body));
        }
        return null;
      });
      moviePrimaryInfoApiResult = await moviePrimaryInfoApiResponse;
      isMoviePrimaryInfoLoaded = true;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      notifyListeners();
    }
  }

  void loadCategory(Movie movie) async {
    log("Loading category");
    try {
      Future<MovieCastApiResponse?> movieCastApiResponse = Future(() async {
        final response = await http.get(Uri.parse(
            "https://api.themoviedb.org/3/movie/${movie.id}/credits?api_key=${MovieFinderConstants.apiKey}"));
        if (response.statusCode == 200) {
          return MovieCastApiResponse.fromJson(jsonDecode(response.body));
        }
        return null;
      });
      movieCastApiResult = await movieCastApiResponse;
      isMovieCastLoaded = true;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  void loadMovies() async {

    try {
      log("Loading movies");
      Future<MovieApiResponse?> movieResponseFuture = Future(() async {
        var response = await http.get(Uri.parse(
            "https://api.themoviedb.org/3/discover/movie?api_key=${MovieFinderConstants.apiKey}&page=1"));
        if (response.statusCode == 200) {
          var movieApiResponse =
              MovieApiResponse.fromJson(jsonDecode(response.body));
          return movieApiResponse..results!.take(10);
        } else {
          return null;
        }
      });
      log("Loaded  movies");
      movieApiResult = await movieResponseFuture;
      isMovieApiLoaded = true;
      notifyListeners();
    } catch (e) {
      log(e.toString());
      isMovieApiLoaded = true;
      notifyListeners();
    }
  }
}
