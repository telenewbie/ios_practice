import UIKit

var str = "Hello, playground"

import UIKit

enum ero : Error{
    case essEro
    case essEro2
}

func alwaysThrows() throws {
    throw ero.essEro
}

func someFunction(callback: ()throws->Void, callback2: ()throws->Void) rethrows{
    do{
        try callback2()
        try callback()
                // Invalid, alwaysThrows() isn't a throwing parameter
    }catch{
        print("2")
        try alwaysThrows()
        throw ero.essEro
    }
}
do{
    try someFunction(callback: {
        print("\(ero.essEro)+\(#line)")
        throw ero.essEro
    }, callback2: {
        print("\(ero.essEro2)+\(#line)")
        throw ero.essEro2
    })
}catch(ero.essEro) {
    print("\(ero.essEro)+\(#line)")
}

let number7 = 5
var str4 = ""
switch number7 {
case 2,3,5,7,11,13,17,19:
    str4 += "It is a prime number. "
    if(number7 == 7){
        break
    }
        
    
    fallthrough
case 100,200:
    str4 += "Fallthrough once. "
default:
    str4 += "Fallthrough twice."
}

// 印出：
// It is a prime number. Fallthrough once. Fallthrough twice.
print(str4)

class A{
    open var name:String = ""
    private var age:Int = 0
    internal var sex:UInt8 = 0
    fileprivate var hobby:String = ""
}

func f(_ x: inout Int) {
    x = 10
}

var a = 1
f(&a)
print(a) // 10
struct Foo {
    var foo: Int

//    mutating func mutate() {
//        foo += 1 // this is mutating self
//    }
}

let f = Foo(foo: 1)
print(f.foo)
