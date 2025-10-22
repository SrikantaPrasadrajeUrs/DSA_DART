// ---------------- VEHICLE EXAMPLE ----------------

// ✅ Vehicle inherits from Car
class Vehicle {
  void move() => print("🚙 Vehicle is moving on road...");
}

class Car implements Vehicle{
  @override
  void move() => print("🚗 Car is moving...");
}

// ✅ Flyable mixin can ONLY be used on Vehicle or its subclasses
mixin Flyable on Vehicle {
  @override
  void move() {
    print("✈️ Preparing for flight...");
    super.move(); // Calls Vehicle.move()
    print("🚀 Flying high in the sky!");
  }
}

// ✅ Correct way: single constraint
mixin Swimmable on Vehicle, Car {
  @override
  void move() {
    print("🏊‍♂️ Preparing for swim...");
    super.move(); // Calls Vehicle.move()
    print("🌊 Swimming in the water!");
  }
}

// ✅ AmphibiousCar combines multiple mixins
class AmphibiousCar extends Car with Flyable, Swimmable {
  @override
  void move() {
    print("🚘 AmphibiousCar special start...");
    super.move(); // Resolution: Swimmable → Flyable → Vehicle → Car
    print("🏁 AmphibiousCar finished!");
  }
}

// ---------------- SUPERHERO EXAMPLE ----------------
class Human {
  void identity() => print("🙂 I’m just a human.");
}

mixin Strength on Human {
  @override
  void identity() {
    super.identity();
    print("💪 Super strength unlocked!");
  }
}

mixin Flight on Human {
  @override
  void identity() {
    super.identity();
    print("🦅 I can fly in the sky!");
  }
}

// ✅ Multiple powers applied in order: Strength → Flight
class SuperHero extends Human with Strength, Flight {}
// Order matters: Flight will come AFTER Strength in the chain

// ---------------- MAIN METHOD ----------------
void main() {
  print("----- AmphibiousCar Demo -----");
  AmphibiousCar ac = AmphibiousCar();
  ac.move();

  print("\n----- SuperHero Demo -----");
  SuperHero hero = SuperHero();
  hero.identity();

  print("\n----- Type Checks (Upcasting) -----");

  // ✅ AmphibiousCar is also a Vehicle
  Vehicle v = AmphibiousCar();
  v.move(); // Works (dynamic dispatch → AmphibiousCar.move)

  // ✅ AmphibiousCar is also a Car (because Vehicle extends Car)
  Car c = AmphibiousCar();
  c.move(); // Works too

  // ❌ ERROR: You cannot instantiate a mixin directly
  // Flyable f = Flyable(); // ❌ invalid

  // ✅ But you can check if an object "is" a mixin type
  print(ac is Flyable);   // true
  print(ac is Swimmable); // true
  print(ac is Car);       // true
  print(ac is Human);     // false
}
