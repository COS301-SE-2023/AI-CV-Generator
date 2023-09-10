
import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/WebScraper/JobScrapeRequest.dart';
import 'package:ai_cv_generator/dio/response/WebScraper/JobScrapeResponse.dart';
import 'package:ai_cv_generator/models/webscraper/JobResponseDTO.dart';
import 'package:dio/dio.dart';

class WebScrapperApi extends DioClient {
  static Future<List<JobResponseDTO>?> scrapejobs({
    required String field,
    required String location
  }) async {
    List<JobResponseDTO>? jobs;
    try {
      Response response = await DioClient.dio.post(
        'api/scrape/jobs',
        data: JobScrapeRequest(field: field, location: location).toJson()
      );
      jobs = JobScrapeResponse.fromJson(response.data).jobs;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return jobs;
  }

  static Future<List<JobResponseDTO>?> recommended() async {
    List<JobResponseDTO>? jobs;
    try {
      Response response = await DioClient.dio.get(
        'api/scrape/recommended'
      );
      jobs = JobScrapeResponse.fromJson(response.data).jobs;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return jobs;
  }
}