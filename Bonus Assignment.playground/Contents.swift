import UIKit

func isLeap(year: Int) -> Bool{
    return (year%4==0 && year%100>0) || year%400==0
}

let months = [0, 31, 28, 31, 30, 31, 31, 30, 31, 30, 31, 30, 31]

func julianDate(year: Int, month: Int, day: Int) -> Int {
    let numYears = Array(1900..<(year)).map({(number:Int) -> Int in return isLeap(number) ? 366:365}).reduce(0, combine: +)
    let numMonths = months[0..<month].reduce(0, combine: +)
    return numYears + numMonths + day
}

julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)

isLeap(1960)
isLeap(1900)
isLeap(2000)