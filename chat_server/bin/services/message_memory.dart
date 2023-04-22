enum Current { client, ia }

class MessageMemory {
  String lastRequest = '';
  String lastResponse = '';

  Current currentSpeaker = Current.client;
  Current currentListener = Current.ia;

  MessageMemory._();
  static final _instance = MessageMemory._();

  factory MessageMemory() {
    return _instance;
  }
}
