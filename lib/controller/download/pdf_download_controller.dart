import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:xremitpro/utils/basic_screen_imports.dart';

import '../../backend/utils/custom_snackbar.dart';

class PdfDownloadController extends GetxController {
  /// Pdf download
  final _isDownloadLoading = false.obs;
  bool get isDownloadLoading => _isDownloadLoading.value;
  Future<void> downloadPdf({required String url, required String trx}) async {
    _isDownloadLoading.value = true;
    final http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Directory? appDocDir = await getApplicationDocumentsDirectory();
      final File file = File('${appDocDir.path}/XremitPro-$trx.pdf');
      await file.writeAsBytes(response.bodyBytes);
      _isDownloadLoading.value = false;
      CustomSnackBar.success('Receipt pdf download successfully');
    } else {}
  }
}
