import 'package:get/get.dart';

class ApiService extends GetxService {
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return "Data fetch From API";
  }
}