//: Playground - noun: a place where people can play

import Foundation

protocol Generator {

    associatedtype ReturnType

    func generate() -> ReturnType
}

class StringGenerator: Generator {

    typealias ReturnType = String

    func generate() -> String {
        return "generated"
    }
}

class IntGenerator: Generator {

    typealias ReturnType = Int

    func generate() -> Int {
        return 3
    }
}

// class below won't compile because we can't use a protocol with associated type in any strictly typed constraints. Compiler knows nothing about associated type in Generator protocol and can't determine it

// type erasing doesn't help with this, because you still have homogeneousity requirement, but you can do various things on concrete generators.

//class GeneratorUser {
//
//    let generators: [Generator] = [IntGenerator(), StringGenerator()]
//
//    func returnGenerator() -> Generator {
//        return IntGenerator()
//    }
//
//    func takeGeneratorAsAnArgument(generator: Generator) {
//
//    }
//}

