//
//  ContactPresenter.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/22/21.
//

import Foundation

protocol ContactPresenterInput: AnyObject {
    
    func viewDidLoad()
    
}

protocol ContactPresenterOutput: AnyObject {
    
    func updateView(with contacts: [ContactModel])
    func updateView(with error: String)
}

final class ContactPresenter: ContactPresenterInput, ContactInteractorOutput {

    // MARK: - Properties
    
    weak var view: ContactPresenterOutput?
    private let interactor: ContactInteractorInput
    private let backgroundQueue = DispatchQueue(label: "getContactQueue", qos: .background, attributes: .concurrent)
    
    // MARK: - Initializers
    
    init(interactor: ContactInteractorInput) {
        self.interactor = interactor
    }
    
    // MARK: - Public
    
    func viewDidLoad() {
        backgroundQueue.async { [weak self] in
            self?.interactor.fetchContacts()
        }
    }
    
    func didObtainContacts(_ contacts: [ContactModel]) {
        DispatchQueue.main.async {
            self.view?.updateView(with: contacts)
        }
    }
    
    func didObtainWithFailure(_ error: ContactError) {
        DispatchQueue.main.async {
            self.view?.updateView(with: error.descriptionForUser)
        }
    }
}

