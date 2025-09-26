import 'dart:ffi';

import '../../oops/constructors.dart';

void main() {
  // 🔹 Arithmetic Operators
  int a = 9;
  a = a + 1;
  a = a - 1;
  a = a * 1;
  a = a ~/ 4; // Truncating division operator
  print("a: $a");

  // 🔹 Relational Operators
  print(a == 5);
  print(a != 5);
  print(a > 5);
  print(a < 5);
  print(a >= 5);
  print(a <= 5);

  // 🔹 Logical Operators
  print((a == 5) && a > 5);
  print((a == 5) || a > 5);
  print(!true);

  // 🔹 Bitwise Operators
  print("Bitwise Operators");
  a = 2; // 0010
  int b = 4; // 0100
  print("|: ${a | b}"); // 0110
  print("&: ${a & b}"); // 0000
  /// XOR rules:
  /// If bits are different → result = 1
  /// If bits are the same → result = 0
  ///  0 0 → 0
  ///  0 1 → 1
  ///  1 0 → 1
  ///  1 1 → 0
  print("^: ${a ^ b}"); // 0110

  // Example: Find unique element using XOR
  findUniqueElement([1, 1, 2, 2, 3, 4, 4]);

  // 🔹 Unary Operators
  a = a + 1;
  a++;
  b = b + 1;
  b++;
  a--;
  b--;
  ++a;
  ++b;
  print("a: $a, b: $b");

  // 🔹 Shift Operators
  a = -10; 
  print(">>: ${a >> 1}");  // Right shift
  print("<<: ${a << 1}");  // Left shift
  print(">>>: ${a >>> 2}"); // Unsigned right shift (fills left with 0s)

  // 🔹 Null-aware Operators
  // Null-coalescing assignment
  int? d = 0;
  d ??= 10;

  // Null-coalescing operator
  String? name;
  String displayName = name ?? "Guest";

  // Null-aware method call
  void Function()? func;
  func?.call();

  // Null-assertion operator
  String? name1 = "Kanta";
  print(name1!.length); // ✅ Safe because name isn’t null

  String? nullName;
  // print(nullName!.length); // ❌ Runtime error

  print(displayName); // "Guest"

  // Null-aware spread
  List<int>? numbers = [1, 2, 3];
  List<int> result = [0, ...?numbers];
  print(result); // [0, 1, 2, 3]

  numbers = null;
  print([0, ...?numbers]); // [0]

  // Null-aware cascade
  Person? p;
  p?..name = "Kanta"
   ..age = 22; // Safe, ignored since p is null
}

void findUniqueElement(List<int> arr) {
  int unique = 0;
  for (int i in arr) {
    unique ^= i;
  }
  print("unique: $unique");
  Set<int> set = {};
}
