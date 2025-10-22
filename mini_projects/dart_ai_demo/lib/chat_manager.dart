import 'dart:io';
import 'ai_service.dart';
import 'storage.dart';

/// A command-line chat orchestrator that handles user interaction,
/// integrates with an AI service, and manages chat history persistence.
///
/// This class is responsible for:
/// - Handling real-time console input/output
/// - Communicating with the [AiService] to generate responses
/// - Storing and retrieving chat history via [Storage]
///
/// Example usage:
/// ```dart
/// final chatManager = ChatManager(ai: AiService(), storage: Storage());
/// await chatManager.start();
/// ```
class ChatManager {
  /// The AI service responsible for generating responses.
  final AiService ai;

  /// The storage service used to persist chat history.
  final Storage storage;

  ChatManager({required this.ai, required this.storage});

  /// Starts the interactive chat session in the terminal.
  ///
  /// Commands:
  /// - Type a message to chat with the AI.
  /// - Type `history` to view previous conversations.
  /// - Type `exit` to quit the program.
  Future<void> start() async {
    _printWelcomeMessage();

    while (true) {
      stdout.write("> ");
      final input = stdin.readLineSync()?.trim();

      if (input == null || input.isEmpty) {
        _printError("Please enter a valid input!");
        continue;
      }

      switch (input.toLowerCase()) {
        case 'exit':
          _printGoodbye();
          return;

        case 'history':
          await _showHistory();
          break;

        default:
          await _processChat(input);
      }
    }
  }

  /// Displays all chat history stored in the [Storage].
  Future<void> _showHistory() async {
    final history = await storage.read();

    if (history.isEmpty) {
      _printInfo("No chat history found.");
      return;
    }

    print("\n🗂️  Chat History");
    print("──────────────────────────────────────────────");
    for (final entry in history) {
      print("👤 You: ${entry['input']}");
      print("🤖 AI : ${entry['output']}");
      print("──────────────────────────────────────────────");
    }
    print(""); // Adds spacing after history
  }

  /// Handles user input, sends it to [AiService], prints response, and saves to [Storage].
  Future<void> _processChat(String input) async {
    _printThinking();

    try {
      final output = await ai.chat(input);
      _printAiResponse(output);
        storage.save(input, output);
    } catch (e) {
      _printError("An error occurred: $e");
    }
  }

  /// Prints a welcome message when chat starts.
  void _printWelcomeMessage() {
    print("""
========================================
🤖  Welcome to Dart AI Chat
========================================
💬 Type your message to start chatting.
📜 Type 'history' to view previous chats.
🚪 Type 'exit' to quit the session.
========================================
""");
  }

  /// Prints a goodbye message on exit.
  void _printGoodbye() {
    print("\n👋 Goodbye! Have a productive day.\n");
  }

  /// Prints an AI response with formatting.
  void _printAiResponse(String response) {
    print("\n🤖 AI: $response\n");
  }

  /// Prints a friendly "thinking" indicator.
  void _printThinking() {
    stdout.write("🤔 Thinking...");
    sleep(const Duration(milliseconds: 300));
    print("\r                   \r"); // Clear the "thinking" line
  }

  /// Prints informational messages in a consistent format.
  void _printInfo(String message) => print("ℹ️  $message");

  /// Prints error messages in a consistent format.
  void _printError(String message) => print("❌  $message");
}
