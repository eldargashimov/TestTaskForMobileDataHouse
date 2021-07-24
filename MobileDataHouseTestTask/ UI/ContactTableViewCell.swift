//
//  ContactTableViewCell.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/21/21.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupNameLabel()
        setupNumberlLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupNameLabel() {

        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10.0).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.textColor = .black
    }

    private func setupNumberlLabel() {

        self.addSubview(numberLabel)
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10.0).isActive = true
        numberLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10.0).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0).isActive = true
        numberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        numberLabel.textColor = .black
    }
    
    func configure(with item: ContactModel) {
        nameLabel.text = item.name + " " + item.lastName
        if let phone = item.phone {
            numberLabel.text = phone
        } else {
            numberLabel.text = "Номер отсутствует"
        }
    }
}
