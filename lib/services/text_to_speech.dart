import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  String lastText = '';
  FlutterTts textToSpeech = FlutterTts();

  Future<void> translate(String message) async {
    Completer completer = Completer();
    lastText = message;
    textToSpeech.setLanguage('en-US');
    textToSpeech.completionHandler = () {
      completer.complete();
    };
    await textToSpeech.speak(message);
    return completer.future;
  }

  Future<void> listenLast() async {
    Completer completer = Completer();
    textToSpeech.setLanguage('en-US');
    textToSpeech.completionHandler = () {
      completer.complete();
    };
    textToSpeech.setLanguage('en-US');
    await textToSpeech.speak(lastText);
    return completer.future;
  }
}

extension on String {
  List<String> splitByLength(int length) {
    List<String> pieces = [];
    List<String> words = split(' ');

    String phrase = '';

    do {
      do {
        phrase += ' ${words.removeAt(0)}';
      } while (phrase.length < length && words.isNotEmpty);
      pieces.add(phrase.trim());
      phrase = '';
    } while (words.isNotEmpty);

    return pieces;
  }
}
