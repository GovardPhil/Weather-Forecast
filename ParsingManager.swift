//
//  ParsingManager.swift
//  WeatherForecast
//
//  Created by ПавелК on 13.03.2022.
//

import Foundation
import SwiftyJSON

class ParsingManager {
    static let shared = ParsingManager()
    
   
    func toDoParser (data : Any) -> ToDo {
        
        let toDoJson = JSON(data)
        
        let id = toDoJson["id"].intValue
        let userId = toDoJson["userId"].intValue
        let title = toDoJson["title"].stringValue
        let body = toDoJson["body"].stringValue
        let toDo = ToDo(id: id, userId: userId, title: title, body: body, completed: false)
       return toDo
    }
    func toDosParser (data : Any) -> [ToDo] {
        var toDos = [ToDo]()
        let jsonArray = JSON(data).arrayValue
        
        for json in jsonArray {
            let id = json["id"].intValue
            let userId = json["userId"].intValue
            let title = json["title"].stringValue
            let completed = json["completed"].boolValue
            let toDo = ToDo(id: id, userId: userId, title: title, body: nil, completed: completed)
            toDos.append(toDo)
        }
     return toDos
    }
}
