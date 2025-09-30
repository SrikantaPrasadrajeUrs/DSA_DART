class Animal{
  void makeSound(){
    print("Animal makes a sound");
  }
}

class Dog extends Animal{
  @override
  void makeSound() {
    print("Dog barks");
  }
}

class Cat extends Animal{
  @override
  void makeSound() {
    print("Cat meows");
  }
}

class Vector{
  double x;
  double y;

  Vector(this.x, this.y);

  Vector operator +(Vector vector){
    return Vector(x+vector.x, y+vector.y);
  }

  @override
  String toString() {
    return "Vector(x:$x, y:$y)";
  }
}

void main(){
  // Run time polymorhpism
  Animal myDog = Dog();
  Animal myCat = Cat();

  myDog.makeSound();
  myCat.makeSound();

  Vector v1 = Vector(1,2);
  Vector v2 = Vector(3,4);

  Vector v3 = v1+v2;
  print(v3);

}