import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message.dart';

class StorageService {
  static Future<void> saveMessages(
    String chatName,
    List<Message> messages,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = messages.map((msg) {
      return jsonEncode(msg.toJson());
    }).toList();

    await prefs.setStringList(chatName, data);
  }

  static Future<List<Message>> loadMessages(
    String chatName,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(chatName);

    if (data == null) return [];

    return data
        .map(
          (e) => Message.fromJson(
            jsonDecode(e),
          ),
        )
        .toList();
  }
}