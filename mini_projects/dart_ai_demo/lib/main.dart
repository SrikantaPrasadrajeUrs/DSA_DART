import 'package:dart_ai_demo/ai_service.dart';
import 'package:dart_ai_demo/chat_manager.dart';
import 'package:dart_ai_demo/storage.dart';
import 'package:dotenv/dotenv.dart';

void main(){
  final _env = DotEnv(includePlatformEnvironment: true)..load();
  AiService aiService = AiService(_env['GEMINI_API_KEY']??"");
  Storage storage = Storage("data/history.json");
  final chatManager = ChatManager(ai: aiService, storage: storage);
  chatManager.start();
}