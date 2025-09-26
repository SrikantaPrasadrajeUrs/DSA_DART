// 👉 Normal Function
int add(int a, int b) {
  return a + b;
}

// 👉 Arrow Function (shorthand)
int add2(int a, int b) => a + b;

// 👉 Closure (returns a function)
Function factor(int factor) {
  return (int a) => a * factor;
}

// 👉 Anonymous Function
Function func = (e) => print("🔹 $e");

List<int> numbers = [1, 2, 3, 4];

// 👉 Optional Positional Parameters
String greet(String name, [String? title]) {
  return title != null ? "👋 Hello $title $name" : "👋 Hello $name";
}

// 👉 Optional Named Parameters
void createUser({String? name, int? age}) {
  print("🧑 Name: $name, 🎂 Age: $age");
}

// 👉 Required Named Parameters
void registerUser({required String username, required String password}) {
  print("✅ User: $username, 🔑 Password: $password");
}

// 👉 Mixing Positional + Named
void sendMessage(String message, {String from = "System", String to = "All"}) {
  print("📩 [$from → $to]: $message");
}

void main(List<String> args) {
  // 🔢 Normal
  print("➕ add: ${add(3, 5)}"); // 8

  // ⚡ Arrow
  print("➕ add2: ${add2(10, 20)}"); // 30

  // 🎯 Closure
  var times2 = factor(2);
  print("2x5 = ${times2(5)}"); // 10

  var times3 = factor(3);
  print("3x4 = ${times3(4)}"); // 12

  // 🤖 Anonymous
  func("Hello from anonymous function");

  // 🔄 List Iteration
  numbers.forEach((n) => print("Number: $n"));
  numbers.forEach(print); // shorthand

  // 🙋 Optional Positional
  print(greet("Alice"));           // 👋 Hello Alice
  print(greet("Alice", "Dr."));    // 👋 Hello Dr. Alice

  // 🧑 Optional Named
  createUser(name: "John", age: 25);
  createUser(age: 30);
  createUser();

  // 🔒 Required Named
  registerUser(username: "srikanta", password: "12345");

  // ✉️ Mixing Positional + Named
  sendMessage("Hello!"); 
  sendMessage("Hi!", from: "Alice");
  sendMessage("Welcome", from: "Admin", to: "User123");
}
