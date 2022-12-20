//
//  PostViewCell.swift
//  Navigation
//
//  Created by Андрей Васильев on 15.12.2022.
//

import UIKit

class FirstViewCell: UITableViewCell {

    let fileManagerlabel : UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.numberOfLines = 0
        return label
    }()

    func layout() {
        contentView.addSubview(fileManagerlabel)
        NSLayoutConstraint.activate([
            fileManagerlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            fileManagerlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            fileManagerlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            fileManagerlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCell(model: String) {
        fileManagerlabel.text = model
    }

}
