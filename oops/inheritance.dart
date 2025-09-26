class Person{
  String name;
  Person({required this.name});

  void introduce()=>print("Hi my name is $name.");
}

class Employee extends Person{
  String company;
  Employee(String name, this.company):super(name:name);

  @override
  void introduce() {
    super.introduce();
    print("I work at $company.");
  }
}

/// THIS keyword
class Product {
  String name;
  double price;

  Product(String name, double price):this.name = name, this.price = price;

  void details() {
    print("Product: ${this.name}, Price: ${this.price}");
  }
}

// Constructor Redirection with this
class Point{
  double x;
  double y;

  Point(this.x, this.y);

  Point.origin():this(0,0); // calling another constructor

}


void main(List<String> args){
  Employee emp = Employee("Srikanta", "Nvidia");
  emp.introduce();
}