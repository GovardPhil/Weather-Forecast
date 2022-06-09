//
//  PostsViewController.swift
//  WeatherForecast
//
//  Created by ПавелК on 15.03.2022.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet weak var toDosTableView: UITableView!
    var toDos = [ToDo]()
    let userId = 56
    override func viewDidLoad() {
        super.viewDidLoad()
        toDosTableView.delegate = self
        toDosTableView.dataSource = self
        fetchData()
    }
    
    @IBAction func addToDo(_ sender: UIButton) {
        let alert = UIAlertController(title: "Новая задача",
                                              message: "Введите название и описание задачи",
                                      preferredStyle:  .alert)
        alert.addTextField { tf in
            tf.placeholder = "Название задачи"
        }
        alert.addTextField { tf in
            tf.placeholder = "Описание задачи"
        }
        let title = alert.textFields![0].text!
        let body = alert.textFields![1].text!
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else {return}
        let task = ToDo(id: nil, userId: userId, title: title, body: body, completed: false)
        let sendAction = UIAlertAction(title: "Отправить", style: .default) { _ in
            AlamofireManager.shared.sendRequest(to: url ,
                                                        object: task,
                                                httpMethod: .post) { todo in
                print("New task was created.ID :\(todo.id)")
            }
        }
        alert.addAction(sendAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func fetchData () {
        
        Task {
            do {
                self.toDos = try await AsyncNetworkManager.shared.getPosts(url: "https://jsonplaceholder.typicode.com/todos")
                self.toDosTableView.reloadData()
            } catch {
                print(error)
            }
        }
    }

}
extension PostsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = toDos[indexPath.row].title
        return cell
    }
    
   
}
