import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:drama_chaska/ui/home_page/model/get_movies_series_model.dart';
import 'package:drama_chaska/utils/api.dart';
import 'package:drama_chaska/utils/app_exception.dart';
import 'package:drama_chaska/utils/utils.dart';

class GetMoviesSeriesApi {
  GetMoviesSeriesModel? getMoviesSeriesModel;

  static Future<GetMoviesSeriesModel?> callApi() async {
    try {
      final url = Uri.parse(ApiConstant.getBaseURL() + ApiConstant.getMoviesSeries);
      log("Get Movies Series Url :: $url");

      final headers = {"key": ApiConstant.SECRET_KEY, 'Content-Type': 'application/json'};
      log("Get Movies Series Headers :: $headers");

      final response = await http.get(url, headers: headers);

      log("Get Movies Series Status Code :: ${response.statusCode}");
      log("Get Movies Series Response :: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return GetMoviesSeriesModel.fromJson(jsonResponse);
      }
      log("Get Movies Series Api Called Successfully");
    } on AppException catch (exception) {
      Utils.showToast(Get.context!, exception.message);
    } catch (e) {
      log("Error call Get Movies Series Api :: $e");
    } finally {}
    return null;
  }
}
