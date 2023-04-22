import 'dart:async';

import 'package:flutter_view_controller/flutter_view_controller.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToText {
  String result = '';
  Timer? timer;

  stt.SpeechToText speechToText = stt.SpeechToText();
  Plug<String> onListen = Plug();

  listen() async {
    await speechToText.initialize();

    speechToText.listen(
      onResult: (result) async {
        if (timer != null) {
          timer!.cancel();
        }
        timer = Timer(const Duration(milliseconds: 1000), () {
          onListen.send(result.recognizedWords);
          speechToText.cancel();
        });
      },
    );
  }
}
