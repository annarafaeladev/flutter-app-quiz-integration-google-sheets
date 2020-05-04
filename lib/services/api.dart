import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_flutter/models/question.dart';

class QuizApi {
  static Future<List<Question>> fetch() async {
    try {
      var url =
          'https://script.googleusercontent.com/macros/echo?user_content_key=BO3ICcMbS-Med9kpjOIV2y5dxKllpHTTtw1RoYKrBmf2SVorgic4O09hhb1mu2b_gRTWgReT79Agbc9bvZXqHusN-Gftaylrm5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnBkUnyLp5DEGADKiDWVte66aTxCrirC37j6rz4OSmF-s4anhdgqjQTvrQIBHSs5vGEWY2nZ7HPw5&lib=MFWAUsuB5CNMsfftHSDyoUE-EQTkuueRl';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return List<Question>.from(
            data["questions"].map((x) => Question.fromMap(x)));
      } else {
        return List<Question>();
      }
    } catch (error) {
      print(error);
      return List<Question>();
    }
  }
}
