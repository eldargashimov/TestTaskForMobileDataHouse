//
//  MainViewController.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/22/21.
//

import UIKit
import Contacts

final class ContactsViewController: UIViewController {
    
    var presenter: ContactPresenterInput?
    
    // MARK: - Subviews
    
    private let tableView = UITableView()
    
    // MARK: - Properties
    
    private var contacts: [ContactModel] = []
  
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Private funcs
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.separatorStyle = .none
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "contact")
    }
}

extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let contactCell = tableView.dequeueReusableCell(withIdentifier: "contact") as? ContactTableViewCell else {
            return UITableViewCell()
        }
        if indexPath.row % 2 != 0 {
            contactCell.backgroundColor = .lightGray
        } else {
            contactCell.backgroundColor = .white
        }
        
        let item = contacts[indexPath.row]
        contactCell.configure(with: item)
        
        return contactCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showPhoneNumberAlert(indexPath: indexPath)
    }
    
    // MARK: - Private
    
    private func showAlertWith(message: String) {
        
        let noNumberAlert = UIAlertController(title: "Упс!", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
        noNumberAlert.addAction(alertAction)
        present(noNumberAlert, animated: true, completion: nil)
    }
    
    private func showPhoneNumberAlert(indexPath: IndexPath) {
        
        guard let validatePhone = contacts[indexPath.row].validatePhone,
            let contactURL: URL = URL(string: "TEL://\(validatePhone)")
        else {
            showAlertWith(message: "Отсутствует номер телефона.")
            return
        }
      
        UIApplication.shared.open(contactURL, options: [:], completionHandler: nil)
    }
}

// MARK: - ContactPresenterOutput

extension ContactsViewController: ContactPresenterOutput {
    
    func updateView(with contacts: [ContactModel]) {
        self.contacts = contacts
        tableView.reloadData()
    }
    
    func updateView(with error: String) {
        showAlertWith(message: error)
    }
}
