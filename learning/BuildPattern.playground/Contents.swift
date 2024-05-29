import Foundation

protocol Animal {
    func Eat()
}

class Dog:Animal{
    func Eat() {
        print("Banana")
    }
}

class Cat:Animal{
    func Eat() {
        print("Fish")
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


