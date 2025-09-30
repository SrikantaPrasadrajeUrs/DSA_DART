/// 📝 Abstract class that defines a generic Vehicle
/// - Cannot be instantiated directly
/// - Provides abstract methods (`start`, `stop`)
/// - Provides a concrete method (`displayInfo`)
abstract class Vehicle {
  void start();  // abstract method
  void stop();   // abstract method

  void displayInfo() {
    print("🚘 This is a vehicle");
  }
}

/// 🚗 A concrete class that extends Vehicle
class Car extends Vehicle {
  @override
  void start() {
    print("🚗 Car started");
  }

  @override
  void stop() {
    print("🚗 Car stopped");
  }
}

/// 🛵 Another concrete class extending Vehicle
class Bike extends Vehicle {
  @override
  void start() {
    print("🏍️ Bike started");
  }

  @override
  void stop() {
    print("🏍️ Bike stopped");
  }

  @override
  void displayInfo() {
    // Override + call super
    super.displayInfo();
    print("🏍️ Specifically, this is a Bike");
  }
}

/// 🔷 Abstract class defining a generic Shape
abstract class Shape {
  double area();  // abstract method
}

/// ⭕ Circle implements Shape
class Circle implements Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => 3.14 * radius * radius;
}

/// 🟦 Square implements Shape
class Square implements Shape {
  final double side;
  Square(this.side);

  @override
  double area() => side * side;
}

/// 🔺 Triangle implements Shape
class Triangle implements Shape {
  final double base;
  final double height;
  Triangle(this.base, this.height);

  @override
  double area() => 0.5 * base * height;
}

void main() {
  print("=== 🚗 Vehicle Abstraction Example ===");
  Car myCar = Car();
  myCar.start();
  myCar.stop();
  myCar.displayInfo();

  print("\n=== 🏍️ Another Vehicle (Bike) ===");
  Bike myBike = Bike();
  myBike.start();
  myBike.stop();
  myBike.displayInfo();

  print("\n=== 🔷 Shape Abstraction Example ===");
  List<Shape> shapes = [
    Circle(5),
    Square(4),
    Triangle(6, 3),
  ];

  for (var shape in shapes) {
    print("📐 Area: ${shape.area()}");
  }
}
