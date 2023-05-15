import 'package:netflix_clone/core/strings.dart';
import 'package:netflix_clone/infrastructure/api_key.dart';

class ApiEndpoints {
  static const downloads = "$kbaseUrl/trending/all/day?api_key=$apikey";
  static const search = "$kbaseUrl/search/movie?api_key=$apikey";
  static const hotAndNew = "$kbaseUrl/discover/movie?api_key=$apikey";
   static const homepage = "$kbaseUrl/trending/all/day?api_key=$apikey";
}
  //  "/trending/all/day?api_key=c2e2608024beabac09aa26c5fb840229"