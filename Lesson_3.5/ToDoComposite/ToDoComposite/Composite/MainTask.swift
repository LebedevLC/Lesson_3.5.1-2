//
//  MainTask.swift
//  ToDoComposite
//
//  Created by Сергей Чумовских  on 20.12.2021.
//

import Foundation

class MainTask: TaskProtocol {
    
    var name: String
    var subTasks: [TaskProtocol]
    
    init(name: String, subTasks: [TaskProtocol]) {
        self.name = name
        self.subTasks = subTasks
    }
    
    func addSubtask(subTask: TaskProtocol) {
        self.subTasks.append(subTask)
    }
}
