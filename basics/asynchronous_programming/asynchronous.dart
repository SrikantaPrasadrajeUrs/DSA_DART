// ✅ Futures
// ✅ async / await
// ✅ Microtask queue vs Event queue
// ✅ Future.delayed, scheduleMicrotask
// ✅ Event loop visualization
// ---------------------------------------------------------
import 'dart:async';


// ===================================================================
// 🧩 Example 1: Basic Future and async/await
// ===================================================================
Future<String> fetchData1() {
  // Simulates fetching data from a server
  return Future.delayed(
    const Duration(seconds: 2),
    () => "📦 Data loaded successfully!",
  );
}

Future<void> example1() async {
  print('\n🔹 Example 1: async/await with Future 🔹');

  print('➡️ Start');
  String data = await fetchData1(); // Waits for 2 seconds
  print('✅ $data');
  print('🏁 End');
}



// ===================================================================
// 🧩 Example 2: .then() and catchError()
// ===================================================================
Future<String> fetchData2() {
  return Future.delayed(
    const Duration(seconds: 1),
    () => "📬 Data from server",
  );
}

Future<void> example2() async {
  print('\n🔹 Example 2: Future.then() / catchError 🔹');

  fetchData2()
      .then((data) => print("✅ $data"))
      .catchError((error) => print("❌ Error: $error"))
      .whenComplete(() => print("🧹 Task completed"));
}



// ===================================================================
// 🧩 Example 3: async/await with try/catch/finally
// ===================================================================
Future<String> riskyFetchData() async {
  await Future.delayed(const Duration(seconds: 1));
  throw Exception("Server error!");
}

Future<void> example3() async {
  print('\n🔹 Example 3: try / catch / finally 🔹');

  try {
    var data = await riskyFetchData();
    print('✅ $data');
  } catch (e) {
    print('⚠️ Caught error: $e');
  } finally {
    print('🧩 Done!');
  }
}



// ===================================================================
// 🧩 Example 4: Event Loop Ordering (Microtask vs Event Queue)
// ===================================================================
void example4() async {
  print('\n🔹 Example 4: Event Loop Order 🔹\n');

  print('A️⃣  - Synchronous start');

  // 👇 Goes to Event Queue
  Future(() => print('B️⃣  - Future() → Event Queue'));

  // 👇 Goes to Microtask Queue
  Future.microtask(() => print('C️⃣  - Future.microtask() → Microtask Queue'));

  // 👇 Same priority as Future.microtask()
  scheduleMicrotask(() => print('F️⃣  - scheduleMicrotask() → Microtask Queue'));

  // 👇 Goes to Event Queue after microtasks
  Future.delayed(Duration.zero, () => print('D️⃣  - Future.delayed(0) → Event Queue'));

  print('E️⃣  - Synchronous end');
}



// ===================================================================
// 🧩 Example 5: await + event loop interaction
// ===================================================================
Future<void> example5() async {
  print('\n🔹 Example 5: await + Event Queue Flow 🔹');

  print('A');
  Future(() => print('B'));
  Future.microtask(() => print('C'));
  await Future.delayed(Duration.zero, () => print('D'));
  print('E');
}



// ===================================================================
// 🧩 Example 6: Combining microtasks, delayed, and normal futures
// ===================================================================
Future<void> fetchData() => Future.delayed(
      const Duration(seconds: 2),
      () => print("📦 Data1 (from fetchData)"),
    );

Future<void> example6() async {
  print('\n🔹 Example 6: scheduleMicrotask + Future.delayed + await 🔹\n');

  print('A️⃣  - Synchronous start');

  Future(() => print('B️⃣  - Future() → Event Queue'));
  Future.microtask(() => print('C️⃣  - Future.microtask() → Microtask Queue'));
  scheduleMicrotask(() => print('F️⃣  - scheduleMicrotask() → Microtask Queue'));
  Future.delayed(Duration.zero, () => print('D️⃣  - Future.delayed(0) → Event Queue'));

  print('E️⃣  - Synchronous end');

  print('\n🕒 Waiting for fetchData() (2 seconds)...');
  await fetchData();

  print('✅ All done! Main resumed after await.\n');
}



// ===================================================================
// 🧩 Example 7: Execution Order Diagram (ASCII visualization)
// ===================================================================
void example7() {
  print('''
🔹 Example 7: Dart Event Loop Visualization 🔹

Main Thread runs synchronously ⏩
┌──────────────────────────────┐
│ 1️⃣ print('A')              │ → runs immediately
│ 2️⃣ Future(() => 'B')       │ → added to Event Queue
│ 3️⃣ Future.microtask('C')   │ → added to Microtask Queue
│ 4️⃣ scheduleMicrotask('F')  │ → Microtask Queue
│ 5️⃣ Future.delayed(0, 'D')  │ → Event Queue
└──────────────────────────────┘

🧠 Execution order:
  1. Synchronous: A, E
  2. Microtasks:  C, F
  3. Event Queue: B, D
  4. Await resumes main(): E (if paused)

🎯 Final output order (from example5 or 6):
  A
  C
  F
  B
  D
  E
''');
}



// ===================================================================
// 🏁 MAIN: Run all examples one by one
// ===================================================================
Future<void> main() async {
  print('''
==========================================
🚀 DART ASYNC MASTERCLASS - START
==========================================
  🌐 Topics Covered:
   - Futures and async/await
   - .then(), catchError()
   - try/catch/finally
   - Microtasks vs Event Queue
   - await flow
==========================================
''');

  await example1();   // async/await
  await Future.delayed(const Duration(milliseconds: 500));
  await example2();   // then/catchError
  await Future.delayed(const Duration(milliseconds: 500));
  await example3();   // try/catch
  await Future.delayed(const Duration(milliseconds: 500));
  example4();         // microtask vs event queue
  await Future.delayed(const Duration(seconds: 2));
  await example5();   // await + flow
  await Future.delayed(const Duration(seconds: 2));
  await example6();   // scheduleMicrotask + delayed
  await Future.delayed(const Duration(milliseconds: 500));
  example7();         // visual diagram

  print('''
==========================================
🏁 END OF ASYNC MASTERCLASS
==========================================
''');
}
