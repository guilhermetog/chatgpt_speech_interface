import 'package:english_friend/services/speech_to_text.dart';
import 'package:english_friend/services/text_to_speech.dart';
import 'package:flutter_view_controller/flutter_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'services/http_client.dart';

enum ConversationState {
  recording,
  waitingForResponse,
  listening,
  idle,
}

class AppPageController extends Controller {
  Notifier<ConversationState> state = Notifier(ConversationState.idle);
  late SpeechToText speechToText;
  late HttpClient httpClient;
  late TextToSpeech textToSpeech;

  @override
  onInit() {
    _configSpeechToText();
    _configHttpClient();
    _configTextToSpeech();
  }

  _configSpeechToText() {
    speechToText = SpeechToText();
    speechToText.onListen.get(_sendText);
  }

  _configHttpClient() {
    httpClient = HttpClient();
    httpClient.onReceiveMessage.get(_getServeMessage);
  }

  _configTextToSpeech() {
    textToSpeech = TextToSpeech();
  }

  _sendText(String message) {
    state.value = ConversationState.waitingForResponse;
    httpClient.sendMessage(message);
  }

  _getServeMessage(String message) async {
    state.value = ConversationState.listening;
    await textToSpeech.translate(message);
    state.value = ConversationState.idle;
  }

  record() {
    if (state.value == ConversationState.idle) {
      state.value = ConversationState.recording;
      speechToText.listen();
    }
  }

  listenLastResponse() async {
    state.value = ConversationState.listening;
    await textToSpeech.listenLast();
    state.value = ConversationState.idle;
  }

  @override
  onClose() {}
}

class AppPageView extends View<AppPageController> {
  AppPageView({required AppPageController controller})
      : super(controller: controller);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: controller.record,
          child: Container(
            height: size.height * 0.2,
            width: size.height * 0.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height * 0.15),
              color: Colors.red,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  color: Colors.black26,
                )
              ],
            ),
            child: controller.state.show(
              (state) {
                switch (state) {
                  case ConversationState.recording:
                    return SpinKitWave(
                      color: Colors.white,
                      size: size.height * 0.10,
                    );
                  case ConversationState.waitingForResponse:
                    return SpinKitFadingCircle(
                      color: Colors.white,
                      size: size.height * 0.15,
                    );
                  case ConversationState.listening:
                    return SpinKitFadingCircle(
                      color: Colors.white,
                      size: size.height * 0.15,
                    );
                  case ConversationState.idle:
                    return Icon(
                      Icons.mic,
                      color: Colors.white,
                      size: size.height * 0.10,
                    );
                }
              },
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        GestureDetector(
          onTap: controller.listenLastResponse,
          child: Container(
            height: size.height * 0.2,
            width: size.height * 0.2,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height * 0.15),
              color: Colors.blue,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  color: Colors.black26,
                )
              ],
            ),
            child: controller.state.show(
              (state) {
                switch (state) {
                  case ConversationState.listening:
                    return SpinKitWave(
                      color: Colors.white,
                      size: size.height * 0.10,
                    );
                  default:
                    return Icon(
                      Icons.headphones,
                      color: Colors.white,
                      size: size.height * 0.10,
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
