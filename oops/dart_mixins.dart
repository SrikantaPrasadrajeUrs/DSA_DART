/// 📝 A mixin that provides flying behavior
mixin CanFly {
  void fly() => print("🕊️ I can fly high in the sky!");
}

/// 📝 A mixin that provides swimming behavior
mixin CanSwim {
  void swim() => print("🐟 I can swim in water!");
}

/// 📝 Base class for all animals
class Animal {
  void breathe() => print("🌬️ I can breathe");
}

/// 🐦 Bird: Inherits from Animal and mixes in flying ability
class Bird extends Animal with CanFly {
  @override
  void fly() {
    // Overriding mixin method
    super.fly(); 
    print("🐦 Bird flaps wings to fly!");
  }
}

/// 🐠 Fish: Inherits from Animal and mixes in swimming ability
class Fish extends Animal with CanSwim {}

/// 🦆 Duck: Uses multiple mixins (CanFly + CanSwim)
class Duck extends Animal with CanFly, CanSwim {
  @override
  void swim() {
    // Override mixin method
    print("🦆 Duck paddles in water gracefully!");
  }
}

/// 🐕 Dog: Example with mixin constraint
mixin CanBark on Animal {
  void bark() => print("🐶 Woof! Woof!");
}

class Dog extends Animal with CanBark {}

/// 🧪 Example showing mixin method conflict resolution
mixin A {
  void greet() => print("👋 Hello from A");
}

mixin B {
  void greet() => print("👋 Hello from B");
}

class MyClass with A, B {
  @override
  void greet() {
    super.greet(); // Will call B.greet() (last wins)
    print("🙋 Overridden in MyClass");
  }
}

void main() {
  print("=== 🐦 Bird Example ===");
  Bird b = Bird();
  b.breathe();  // from Animal
  b.fly();      // overridden + super from CanFly

  print("\n=== 🐠 Fish Example ===");
  Fish f = Fish();
  f.breathe();  // from Animal
  f.swim();     // from CanSwim

  print("\n=== 🦆 Duck Example (Multiple Mixins) ===");
  Duck d = Duck();
  d.breathe();
  d.fly();      // from CanFly
  d.swim();     // overridden in Duck

  print("\n=== 🐕 Dog Example (Mixin Constraint) ===");
  Dog dog = Dog();
  dog.breathe(); // from Animal
  dog.bark();    // from CanBark

  print("\n=== ⚔️ Conflict Resolution Example ===");
  MyClass obj = MyClass();
  obj.greet(); // Hello from B + Overridden in MyClass
}
