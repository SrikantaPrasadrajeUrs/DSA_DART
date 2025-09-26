class Person {
  // 🔹 Cache to store created Person objects
  static final Map<String, Person> _cache = {};

  String name;
  int age;

  // 🔹 Private named constructor
  Person._internal(this.name, this.age);

  // 🔹 Factory constructor with caching
  factory Person(String name, int age) {
    return _cache.putIfAbsent(
      name,
      () => Person._internal(name, age),
    );
  }

  // 🔹 Named constructor for guest user
  Person.guest()
      : name = "Guest",
        age = 0;
}

void main() {
  var p1 = Person("Srikanta", 9);
  var p2 = Person("Srikanta", 9);
  var p3 = Person.guest();

  print("${p1.hashCode} -- ${p2.hashCode}"); // Same ✅
  print("${p3.name} -- ${p3.age}"); // Guest -- 0
}
