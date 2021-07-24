//
//  ContactInteractor.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/22/21.
//

import Foundation

protocol ContactInteractorInput {
    
    func fetchContacts()
}

protocol ContactInteractorOutput: AnyObject {
    
    func didObtainContacts(_ contacts: [ContactModel])
    
    func didObtainWithFailure(_ error: ContactError)
}

final class ContactInteractor: ContactInteractorInput {
    
    weak var presenter: ContactInteractorOutput?
    
    // MARK: - Properties
    
    private let service: ContactServiceProtocol
    
    
    // MARK: - Initializers
    
    init(service: ContactServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Public
    
    func fetchContacts() {
        
        let result = service.getContact()
        
        switch result {
        case .success(let contacts):
            let newContacts = contacts.compactMap({
                ContactModel(
                    name: $0.givenName,
                    lastName: $0.familyName,
                    phone: $0.phoneNumbers.first?.value.stringValue
                )
            })
        
            presenter?.didObtainContacts(newContacts)
            
        case .failure(let error):
            presenter?.didObtainWithFailure(error)
        }
    }
}
 
