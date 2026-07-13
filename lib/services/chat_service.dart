import '../models/message.dart';
import 'storage_service.dart';

class ChatService {
  static Future<List<Message>> getMessages(String chatName) async {
    return await StorageService.loadMessages(chatName);
  }

  static Future<void> saveMessages(
    String chatName,
    List<Message> messages,
  ) async {
    await StorageService.saveMessages(chatName, messages);
  }
}