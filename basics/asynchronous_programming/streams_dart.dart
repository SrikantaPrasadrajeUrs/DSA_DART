// 🎯 DART ASYNCHRONOUS PROGRAMMING: Streams, Generators, and Controllers
// ----------------------------------------------------------
// 📘 Concepts covered:
//  ✅ async* & yield → Asynchronous Generators
//  ✅ sync* & yield → Synchronous Generators
//  ✅ Single-subscription Streams
//  ✅ Broadcast Streams
//  ✅ StreamController (manual stream control)
//  ✅ Timer.periodic behavior
//  ✅ Event Loop insight with Future.delayed
// ----------------------------------------------------------

import 'dart:async';

/// 🌊 Asynchronous Stream Generator
/// Produces values *asynchronously* using `async*` and `yield`.
/// Each `yield` emits a new value to any listeners on the stream.
///
/// Think of it like an async `for` loop that *waits* before producing data.
Stream<int> count(int k) async* {
  for (int i = 0; i < k; i++) {
    await Future.delayed(Duration(milliseconds: 100)); // Simulate async work
    print("🔹 count() producing: $i");
    yield i; // Emit a value to stream listeners
  }
}

/// 🔁 Synchronous Generator (Iterable)
/// Uses `sync*` and `yield` to return values immediately, without async delays.
/// Returns an `Iterable<int>` instead of a `Stream<int>`.
Iterable<int> countNumSync(int k) sync* {
  for (int i = 0; i < k; i++) {
    print("🔸 countNumSync() yielding: $i");
    yield i;
  }
}

/// 🚀 MAIN FUNCTION
/// Demonstrates async flow using Streams, BroadcastStreams, and StreamControllers.
void main() async {
  print("🏁 MAIN START");

  // ⚡ Example 1: Single-subscription Stream
  // Only one listener is allowed — uncomment below to test:
  // await for (var i in count(5)) {
  //   print("📥 Single listener received: $i");
  // }

  // ⚡ Example 2: Broadcast Stream
  // Allows multiple listeners — handy for UI updates or multiple event consumers.
  var stream = count(5).asBroadcastStream();

  stream.listen((i) => print("🟢 Listener 1 received: $i"));
  stream.listen((i) => print("🟣 Listener 2 received: $i"));

  // ⚙️ Example 3: StreamController
  // Gives manual control over data emission (sink) and listening (stream).
  final streamController = StreamController<int>.broadcast();

  // UI component listening to our custom stream
  streamController.stream.listen((i) => print("💻 UI Stream received: $i"));

  int counter = 0;

  // 🕒 Timer.periodic emits values every 1 second
  Timer.periodic(Duration(seconds: 1), (timer) {
    // Uncomment next line to push data to stream:
    // streamController.sink.add(counter++);
    print("⏱ Timer tick ${timer.tick}");

    // 🧨 If not cancelled, timer keeps the event loop busy forever!
    // Uncomment below to allow 'hello' to print:
    // timer.cancel();
  });

  // 🚫 Closing the controller's sink
  // (even if no data was added — always a good practice)
  streamController.sink.close();

  // 💤 Add a delay to let async operations run
  await Future.delayed(Duration(seconds: 1));

  print("✅ hello printed after 1 second delay");

  // 🧮 Example 4: Using sync* generator
  var syncList = countNumSync(5).toList();
  print("📊 Synchronous iterable length: ${syncList.length}");
  print("🏁 MAIN END");
}

// ----------------------------------------------------------
// 🧠 SUMMARY
// ----------------------------------------------------------
// 🔸 Future<T> → Returns a *single value* asynchronously
// 🔹 Stream<T> → Returns *multiple values* asynchronously over time
// 🔸 sync* + yield → Generate multiple values synchronously (Iterable<T>)
// 🔹 async* + yield → Generate multiple values asynchronously (Stream<T>)
// 🔸 Single-subscription Stream → 1 listener allowed
// 🔹 Broadcast Stream → Multiple listeners allowed (e.g., UI updates)
// 🔸 StreamController → Manual control of adding data to a stream
// 🔹 Timer.periodic → Repeated event source; must cancel to avoid infinite loop
// ----------------------------------------------------------
// 🧭 EXECUTION ORDER (Event Loop)
// 1️⃣ Synchronous code runs first
// 2️⃣ Then Microtasks (Future.microtask, scheduleMicrotask)
// 3️⃣ Then Event Queue (Future, Timer, Stream events)
// ----------------------------------------------------------
