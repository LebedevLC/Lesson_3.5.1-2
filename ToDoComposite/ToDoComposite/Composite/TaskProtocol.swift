//
//  TaskProtocol.swift
//  ToDoComposite
//
//  Created by Сергей Чумовских  on 20.12.2021.
//

import Foundation

protocol TaskProtocol {
    
    var name: String { get set }
    var subTasks: [TaskProtocol] { get set }
}
