//
//  AlamofireManager.swift
//  WeatherForecast
//
//  Created by ПавелК on 13.03.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

enum HttpError : Error {
    case badUrl, badResponse, errorDecodingData, invalidUrl
}
enum  HttpMethod : String {
    case POST, GET, PUT, DELETE
}
enum MIMEType : String {
    case JSONUTF8 = "application/json; charset=UTF-8"
}
enum HttpHeader : String {
    case contentType = "Content-type"
}



class AlamofireManager {
    static let shared = AlamofireManager()
    let urlString : String = "https://jsonplaceholder.typicode.com/todos"
    
    func getRequest (completion : @escaping ([ToDo]) -> Void) {
        guard let urlString = URL(string: urlString) else {
            print("Bad URL")
            return
        }
        AF.request(urlString).responseJSON { response in
            
            switch response.result {
                
            case .success(let data):
                let toDos = ParsingManager.shared.toDosParser(data: data)
                completion(toDos)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sendRequest(to url : URL, object: ToDo, httpMethod : HTTPMethod, completion : @escaping (ToDo) -> Void) {
        let params : Parameters = ["title": object.title,
                                                "userId": object.userId,
                                                "body" : object.body!]
        let headers : HTTPHeaders = []
        AF.request(url,
                   method: .post,
                   parameters: params,
                   headers: headers).responseJSON { response in
            switch response.result {
    
            case .success(let toDo):
               let task = ParsingManager.shared.toDoParser(data: toDo)
                completion(task)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
