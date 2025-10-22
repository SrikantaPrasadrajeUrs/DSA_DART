import 'package:flutter_gemini/flutter_gemini.dart';

class AiService {
  late final Gemini gemini;

  AiService(String apiKey) {
    gemini = Gemini.init(apiKey: apiKey);
  }

  Future<String> chat(String? input) async {
    if (input == null || input.isEmpty) return 'Please provide a valid input';
    final result = await gemini.chat([
      Content(parts: [Part.text(input)])
    ]);
    return result?.output ?? 'No response from AI.';
  }
}
