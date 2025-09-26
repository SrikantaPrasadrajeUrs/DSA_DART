class BankAccount{
  final String _accountNumber;
  double _balance = 0;

  BankAccount(this._accountNumber);

  int withdraw(int amount){
    if(_balance >= amount){
      _balance -= amount;
      return amount;
    }
    throw Exception("Insufficient balance");  
  }

  double deposit(int amt){
    _balance+=amt;
    return _balance;
  }
  
  double get balance => _balance;

}

void main() {
  var account = BankAccount("12345");

  account.deposit(500);
  print(account.balance); // 500

  account.deposit(200);
  print(account.balance); // 700

  account.withdraw(100);
  print(account.balance); // 600
  // account._balance = 10000; // ❌ Error: _balance is private, if you try to access in other file
}