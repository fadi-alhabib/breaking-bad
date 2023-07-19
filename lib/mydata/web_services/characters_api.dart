import 'package:bloc_1/constants/strings.dart';
import 'package:dio/dio.dart';

class CharachtersWebServices {
  late Dio dio;

  CharachtersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharachters() async {
    try {
      Response response = await dio.get('characters');

      return response.data;
    } catch (e) {
      return [];
    }
  }
}
