//
//  ToDoTableViewCell.swift
//  ToDoComposite
//
//  Created by Сергей Чумовских  on 21.12.2021.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    
    static let identifier = "ToDoTableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    
    var cellTapped: (()-> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
    }
    
    func configure(name: String) {
        nameLabel.text = name
        setGesture()
    }
    
    private func setGesture() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        self.addGestureRecognizer(singleTap)
    }
    
    @objc func handleSingleTap() {
        self.cellTapped?()
    }
    
}
