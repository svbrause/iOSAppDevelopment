//: Playground - noun: a place where people can play

import Foundation

let immutableString = "Hello, playground"
var str = "Hello, playground"

str+="0"

var myInt = 42
let myConstant = 50

let implicitDouble = 70.0
let explicitDouble: Double = 70

let label = "the width is "
let width = 94
let widthLabel = label + String(width)
String(94)
let apples = 3
let oranges = 5
var appleSummary = "I have \(apples) apples."
appleSummary = "I have \(oranges) oranges"

var pop = "999"
var lao = 10 + Int(pop)!

var shoppingList: Array = ["please", "don't", "eat", "me", "Mr.", "Cow"]
shoppingList.append("toothpaste")
var occupation:Dictionary<String,String> = [
    "malcolm": "captain",
    "kaylee": "mechanic"
]

occupation["Jayne"] = "public relations"

occupation

var r = 50...100
var g = r.generate()
g.next()
g.next()

var g1 = [11,21,31,41,51].generate()

var tuple = (1, 2)
tuple.0
tuple.1

var tuple2 = (first:"van", second:"simmons")
tuple2.1
for (k,v) in occupation{
    print("\(k),\(v)")
}


func doubler(x:Int) -> Int {
    return x*2
}

func doubleDoubler(x:Double) -> Double {
    return x*2
}


doubler(4)

func progression(v:Int,f:Int->Int) -> Int {
    return f(v)
}

progression(4, f:doubler)

var tf = false
tf = true

var arrArr:Array<Dictionary<Int,Bool>> = [[1:true]]

var closure = { (x:Int) -> Int in
    return x*2
}

closure(90)

progression(6,f:closure)

progression(6, f: { (x:Int) -> Int in
    return x*2
})

var lol = [0,1,2,3,4,5,6,7,8,9,10]

var occupationNames = occupation.map {print($0.0)}

var printf = lol.map{print($0)}

var optionalN:Int? = 12
var implicitOptionalN:Int! = 14

if let n = optionalN {
    let doubleN = doubler(n)
}

doubler(implicitOptionalN)







