import UIKit

// Model1
struct Model1: Codable {
    let data: [Person]
}

// Model2
struct Model2: Codable {
    let result: [Person]
}

// Model3
struct Person: Codable {
    let name: String
    let age : Int
    let isDeveloper: Bool
}

protocol PersonHandler {
    
    var next: PersonHandler? { get set }
    
    func handlePerson(_ person: Data) -> [Person]?
}

class PersonParserFromData: PersonHandler {
    
    var next: PersonHandler?
    
    func handlePerson(_ person: Data) -> [Person]? {
        debugPrint("Use PersonParserFromData")
        guard let arrayPerson = try? JSONDecoder().decode(Model1.self, from: person)
        else {
            return self.next?.handlePerson(person)
        }
        debugPrint("return from PersonParserFromData")
        return arrayPerson.data
    }
}

class PersonParserFromResult: PersonHandler {
    
    var next: PersonHandler?
    
    func handlePerson(_ person: Data) -> [Person]? {
        debugPrint("Use PersonParserFromData")
        guard let arrayPerson = try? JSONDecoder().decode(Model2.self, from: person)
        else {
            return self.next?.handlePerson(person)
        }
        debugPrint("return from PersonParserFromResult")
        return arrayPerson.result
    }
}

class PersonParserFromDefault: PersonHandler {
    
    var next: PersonHandler?
    
    func handlePerson(_ person: Data) -> [Person]? {
        debugPrint("Use PersonParserFromDefault")
        guard let arrayPerson = try? JSONDecoder().decode([Person].self, from: person)
        else {
            return self.next?.handlePerson(person)
        }
        debugPrint("return from PersonParserFromDefault")
        return arrayPerson
    }
}

let personParserFromData = PersonParserFromData()
let personParserFromResult = PersonParserFromResult()
let personParserFromDefault = PersonParserFromDefault()
let personHandler: PersonHandler = personParserFromData

personParserFromData.next = personParserFromResult
personParserFromResult.next = personParserFromDefault
personParserFromDefault.next = nil

func requestData(fileName: String) -> [Person] {
    guard let path = Bundle.main.path(forResource: fileName, ofType: "json")
    else {
        debugPrint("File (\(fileName)) not found!")
        return [] }
    let url = URL(fileURLWithPath: path)
    let data = try! Data(contentsOf: url)

    if let persons = personParserFromData.handlePerson(data) {
        return persons
    } else {
        debugPrint("Decode ERROR")
        return [] }
}

requestData(fileName: "1")
requestData(fileName: "2")
requestData(fileName: "3")
requestData(fileName: "4")
