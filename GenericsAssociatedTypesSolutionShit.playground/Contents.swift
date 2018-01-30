//: Playground - noun: a place where people can play

import Foundation

protocol Generator {

    associatedtype ReturnType

    func generate() -> ReturnType
    func doSomething(returnType: ReturnType)
}

class StringGenerator: Generator {

    typealias ReturnType = String

    func generate() -> String {
        return "generated"
    }

    func doSomething(returnType: String) {
    }
}

class IntGenerator: Generator {

    typealias ReturnType = Int

    func generate() -> Int {
        return 3
    }

    func doSomething(returnType: Int) {
    }
}

private class _AnyGeneratorBase<ReturnTypeGeneric>: Generator {

    typealias ReturnType = ReturnTypeGeneric

    func generate() -> ReturnTypeGeneric {
        fatalError("must override")
    }

    func doSomething(returnType: ReturnTypeGeneric) {
        fatalError("must override")
    }

}

private final class _AnyGeneratorDecorator<ConcreteGenerator: Generator>: _AnyGeneratorBase<ConcreteGenerator.ReturnType> {

    var concreteGenerator: ConcreteGenerator

    init(_ concreteGenerator: ConcreteGenerator) {
        self.concreteGenerator = concreteGenerator
    }

    override func generate() -> ConcreteGenerator.ReturnType {
        return concreteGenerator.generate()
    }

    override func doSomething(returnType: ConcreteGenerator.ReturnType) {
        concreteGenerator.doSomething(returnType: returnType)
    }
}

final class AnyGenerator<ReturnType>: Generator {

    private let generatorBase: _AnyGeneratorBase<ReturnType>

    init<ConcreteGenerator: Generator>(_ concreteGenerator: ConcreteGenerator) where ConcreteGenerator.ReturnType == ReturnType {
        generatorBase = _AnyGeneratorDecorator(concreteGenerator) //decorator subclasses base class
    }

    func generate() -> ReturnType {
        return generatorBase.generate()
    }

    func doSomething(returnType: ReturnType) {
        generatorBase.doSomething(returnType: returnType)
    }
}

// how this solution works: you replace Generator with AnyGenerator<ConcreteStuff> and use it as a requirement.

//so this still doesn't work, and it appears that type erasure is shit worth
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

