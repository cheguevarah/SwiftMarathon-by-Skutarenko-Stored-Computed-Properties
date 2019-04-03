import UIKit
import Foundation

//: 1. Самостоятельно повторить проделанное в уроке
//:2. Добавить студенту property «Дата рождения» (пусть это будет еще одна структура, содержащая день, месяц, год) и два computed property: первое — вычисляющее его возраст, второе — вычисляющее, сколько лет он учился (считать, что он учился в школе с 6 лет, если студенту меньше 6 лет — возвращать 0)


struct Student {
    
    var firstName: String {
        willSet{
            print("Value \(firstName) will be changed on \(newValue) ")
        }
        didSet {
            print("\(oldValue) was changed on \(firstName)")
            firstName = firstName.capitalized
        }
    }
    var lastName: String {
        didSet {
            lastName = lastName.capitalized
        }
    }
    
    var fullName: String {
        get{
            return firstName + " " + lastName
        }
        set {
            let words = newValue.components(separatedBy: " ")
            if words.count > 0 {
                firstName = words[0]
            }
            if words.count > 1 {
                lastName = words[1]
            }
        }
    }
    
    enum Month: String {
        case January, February
        case March, April, May
        case June, July, August
        case September, October, November
        case December
    }
    
    struct Birthday {
        var day: Int
        var month: Month
        var year: Int
        }
    
    var dateOfBirthday: Student.Birthday
    
    var age: String {
        let yearNow = 2019
        return String(yearNow - dateOfBirthday.year)
    }
    
    var yearsOfStudy: String{
        return String(Int(age)! <= 6 ? 0 : Int(age)! - 6)
    }
    
}

var student1 = Student(firstName: "dima", lastName: "ivanov", dateOfBirthday: Student.Birthday(day: 15, month: .January, year: 1992))

print(student1.yearsOfStudy)
print(student1.age)

//:3. Создать структуру «Отрезок», содержащую две внутренние структуры «Точки». Структуру «Точка» создать самостоятельно, несмотря на уже имеющуюся в Swift’е. Таким образом, структура «Отрезок» содержит две структуры «Точки» — точки A и B (stored properties). Добавить два computed properties: « середина отрезка» и «длина» (считать математическими функциями)
//:4. При изменении середины отрезка должно меняться положение точек A и B. При изменении длины, меняется положение точки B

struct Coordinate {
    var x : Double
    var y : Double
}

struct Segment {

    var pointA : Coordinate
    var pointB : Coordinate
    
    
    var middlePoint : Coordinate {
        get {
        let middleX = (pointA.x + pointB.x) / 2
        let middleY = (pointA.y + pointB.y) / 2
        return Coordinate(x: middleX, y: middleY)
    }
        set {
            let difX = newValue.x - middlePoint.x
            let difY = newValue.y - middlePoint.y
            print("difX = \(difX)")
            print("difY = \(difY)")
            print("newValue = \(newValue)")
            pointA.x += difX
            pointA.y += difY
            
            pointB.x += difX
            pointB.y += difY
        }
    }
    
    var length: Double {
        get{
            return sqrt(pow(pointB.x - pointA.x, 2) + pow(pointB.y - pointA.y, 2))
        }
        set{
            pointB = Coordinate(x: (pointB.x - pointA.x) * newValue / length + pointA.x,
                                y: (pointB.y - pointA.y) * newValue / length + pointA.y)
            
        }
    }
}


var otrezok = Segment(pointA: Coordinate(x: 1, y: 1), pointB: Coordinate(x: 1, y: 10))
print(otrezok.middlePoint)
otrezok.middlePoint = Coordinate(x: 1, y: 20)
print(otrezok)
print(otrezok.length.rounded())
otrezok.length = 1
print(otrezok.pointA, otrezok.pointB)





