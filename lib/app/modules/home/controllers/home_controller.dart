import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
// import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  PlatformFile? filePicked;

  void pilihFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );
    if (result != null) {
      filePicked = result.files.first;
    }
    update();
  }

  Future<void> submit() async {
    try {
      Map<String, dynamic> payload = {
        "type": "write_on",
        "write_on_start_date": "2022-01-01",
        "write_on_end_date": "2022-06-30",
        "channel": [2, 3],
        // "requested_file" : filenya nanti
      };

      List<int> bytes = [];

      for (var element in filePicked!.bytes!) {
        bytes.add(element);
      }

      var dataFile = dio.MultipartFile.fromBytes(bytes);

      var formData = dio.FormData.fromMap({
        ...payload,
        'requested_file': dataFile,
      });

      var response = await dio.Dio().post(
        "MASUKAN URL DISINI", // TODO : <<< URL MOCKUP / DEV
        options: dio.Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "MASUKAN BASIC AUTH DISINI", // TODO : <<< BASIC AUTH MOCKUP / DEV
          },
          contentType: "multipart/form-data",
        ),
        data: formData,
      );

      // ignore: avoid_print
      print(response.statusCode);
      // ignore: avoid_print
      print(response.statusMessage);
      // ignore: avoid_print
      print(response.data);
    } on dio.DioError catch (e) {
      // ignore: avoid_print
      print("==== DIO EXCEPTION ====");
      // ignore: avoid_print
      print(e.message);
      // ignore: avoid_print
      print(e.error);
      // ignore: avoid_print
      print(e.response?.data);
    } catch (e) {
      // ignore: avoid_print
      print("==== CATCH ERROR ====");
      // ignore: avoid_print
      print(e);
    }
  }
}
