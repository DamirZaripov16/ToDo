//
//  TableViewCell.swift
//  ToDo
//
//  Created by Damir Zaripov on 29.05.2023.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    
    let toDoTaskLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(toDoTaskLabel)

        NSLayoutConstraint.activate([
            toDoTaskLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            toDoTaskLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            toDoTaskLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            toDoTaskLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
