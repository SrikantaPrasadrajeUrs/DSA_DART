
import 'dart:ffi';

void main() {
  // Artihmatic Operators
  int a = 9;
  a=a+1;
  a=a-1;
  a=a*1;
  a=a~/4; // Turncating division operator
  print("a: $a");

  // Relational
  print(a==5);
  print(a!=5);
  print(a>5);
  print(a<5);
  print(a>=5);
  print(a<=5);

  // Logical Operators
  print((a==5)&&a>5);
  print((a==5)||a>5);
  print(!true);

  // Bitwise Operator
  print("Bitwise Operators");
  a = 2; //0010
  int b = 4; //0100
  print("|: ${a|b}"); // 0110
  print("&: ${a&b}"); // 0000
  /// If bits are different → result = 1
  /// If bits are the same → result = 0	
  ///  0 0 - 0
  ///  0 1 - 1
  ///  1 0 - 1
  ///  1 1 - 0
  print("^: ${a^b}"); // 0110
  findUniqueElement([1,1,2,2,3,4,4]);
  // Unary operators
  a = a+1; 
  a++;
  b=b+1;
  b++;
  a--;b--;
  ++a;++b;
  print("a: $a, b: $b");

  a = -10; // 1010
  print(">>: ${a>>1}"); // 0101
  print("<<: ${a<<1}"); //10100
  print(">>>: ${a>>>2}"); // shift right side by specified number and fills left with zeros
}

void findUniqueElement(List<int> arr){
  int unique = 0;
  for(int i in arr){
    unique ^=i;
  }
  print("unique: $unique");
}