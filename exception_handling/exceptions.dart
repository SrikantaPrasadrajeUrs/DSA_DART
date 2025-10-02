/*
=======================================================
🔥 Dart Exception Handling — Complete Examples
=======================================================
Concepts covered:
✅ try–catch
✅ on (specific exception types)
✅ catch with stack trace
✅ finally (always executes)
✅ throwing exceptions
✅ custom exceptions
✅ method resolution with multiple catch
✅ upcasting / type checks
=======================================================
*/

void main() {
  // 1) Basic try–catch
  print("----- 1) Basic try–catch -----");
  try {
    int result = 10 ~/ 0; // ~/ = integer division → will throw
    print("Result: $result"); // won't reach here
  } catch (e) {
    print("⚠️ Caught an exception: $e");
  }

  // 2) Catch with stack trace
  print("\n----- 2) Catch with stack trace -----");
  try {
    List<int> numbers = [1, 2, 3];
    print(numbers[5]); // ❌ RangeError
  } catch (e, stack) {
    print("⚠️ Exception: $e");
    print("📌 Stack trace:\n$stack");
  }

  // 3) on keyword (specific exceptions)
  print("\n----- 3) Using 'on' for specific exceptions -----");
  try {
    int result = 10 ~/ 0;
    print(result);
  } on IntegerDivisionByZeroException {
    print("❌ You can’t divide by zero!");
  } on FormatException {
    print("❌ Invalid number format!");
  } catch (e) {
    print("⚠️ Some other error: $e");
  }

  // 4) finally block
  print("\n----- 4) Finally block -----");
  try {
    print("Opening file...");
    throw Exception("File not found!");
  } catch (e) {
    print("⚠️ Error: $e");
  } finally {
    print("📌 Closing file... (always runs)");
  }

  // 5) Throwing exceptions manually
  print("\n----- 5) Throwing exceptions -----");
  try {
    withdrawMoney(7000);
  } catch (e) {
    print("⚠️ Caught: $e");
  }

  // 6) Custom exception demo
  print("\n----- 6) Custom exceptions -----");
  var account = BankAccount();
  try {
    account.withdraw(2000); // ❌ balance is only 1000
  } on InsufficientBalanceException catch (e) {
    print("⚠️ Custom Exception: $e");
  } catch (e) {
    print("⚠️ Other exception: $e");
  } finally {
    print("🏦 Transaction finished.");
  }

  // 7) Type checks (upcasting with exceptions)
  print("\n----- 7) Type checks / upcasting -----");
  try {
    int.parse("hello"); // ❌ FormatException
  } on FormatException catch (e) {
    print("⚠️ FormatException caught: $e");
  }

  // Checking object types at runtime
  var ex = InsufficientBalanceException("Test");
  print(ex is Exception); // true
  print(ex is InsufficientBalanceException); // true
}

/* ---------------- Utility functions & classes ---------------- */

// Example for throwing
void withdrawMoney(int amount) {
  if (amount > 5000) {
    throw Exception("❌ Withdrawal limit exceeded!");
  }
  print("✅ Withdrawn: $amount");
}

// Custom exception
class InsufficientBalanceException implements Exception {
  final String message;
  InsufficientBalanceException(this.message);

  @override
  String toString() => "InsufficientBalanceException: $message";
}

// Bank Account example with custom exception
class BankAccount {
  double balance = 1000;

  void withdraw(double amount) {
    if (amount > balance) {
      throw InsufficientBalanceException(
        "You tried to withdraw $amount but balance is only $balance",
      );
    }
    balance -= amount;
    print("✅ Withdrawal successful. Remaining: $balance");
  }
}
