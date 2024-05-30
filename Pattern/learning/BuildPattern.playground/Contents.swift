import Foundation

protocol Animal {
    func Eat()
}

class Dog:Animal{
    func Eat() {
        print("Banana \(Date())")
    }
}

class Cat:Animal{
    func Eat() {
        print("Fish \(Date())")
    }
}

class Builder {
    let animal:Animal
    init(animal: Animal) {
        self.animal = animal
    }
    func build(){
        self.animal.Eat()
    }
}


let dogBuilder = Builder(animal: Dog())
dogBuilder.build()

let catBuilder = Builder(animal: Cat())
catBuilder.build()
