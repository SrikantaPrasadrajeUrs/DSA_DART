// normal
int add(int a, int b){
  return a+b;
}
// arros
int add2(int a, int b) => a+b;

// closure
Function factor(int factor){
  return (int a) => a*factor;
}

// anonymous function
List<int> numbers = [1,2,3,4];

void main(List<String> args) {
  numbers.forEach((n)=>print(n));
}