//
//  ToDoViewController.swift
//  ToDoComposite
//
//  Created by Сергей Чумовских  on 20.12.2021.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
   
    private var allTasks: [TaskProtocol] = []
    private var currentTask: TaskProtocol? {
        didSet {
            tableView.reloadData()
            backButton.isEnabled = currentTask?.name == "Root" ?  false : true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTask = MainTask(name: "Root", subTasks: [])
        setupTableView()
    }
    
    // MARK: - Buttons
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        currentTask = allTasks.removeLast()
    }
}

// MARK: - TableView

extension ToDoViewController: UITableViewDataSource {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: ToDoTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ToDoTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentTask?.subTasks.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ToDoTableViewCell.identifier,
                for: indexPath) as? ToDoTableViewCell,
            let subTask = currentTask?.subTasks[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.configure(name: subTask.name)
        cell.cellTapped = { [unowned self] in
            guard let currentTask = self.currentTask else { return }
            self.allTasks.append(currentTask)
            self.currentTask = subTask
        }
        return cell
    }
}

// MARK: - Alert

extension ToDoViewController {
    private func showAlert() {
        let alertController = UIAlertController(
            title: "Please, enter some task",
            message: nil,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Add", style: .default) { [unowned self] _ in
            guard
                let name = alertController.textFields?[0].text,
                name != ""
            else { return }
            let newSubTask = MainTask(name: name, subTasks: [])
            self.currentTask?.subTasks.append(newSubTask)
            self.tableView.reloadData()
        }
        alertController.addAction(okAction)
        alertController.addTextField { UITextField -> Void in
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
