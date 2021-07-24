//
//  Contact.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/22/21.
//

import Contacts

final class ContactService: ContactServiceProtocol {
    
    // MARK: - Private properties
    
    private let store: CNContactStore
    private let fetchKeys: [CNKeyDescriptor]
    
    // MARK: - Init
    
    init(store: CNContactStore, fetchKeys: [CNKeyDescriptor]) {
        self.store = store
        self.fetchKeys = fetchKeys
    }
    
    // MARK: - ContactServiceProtocol
    
    func getContact() -> Result<[CNContact], ContactError> {
        var contacts: [CNContact] = []
    
        guard let allContainers = try? store.containers(matching: nil) else {
            return .failure(.containersFetching)
        }
        
        for container in allContainers {
            let predicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
             
            guard let contact = try? store.unifiedContacts(matching: predicate, keysToFetch: fetchKeys) else {
                return .failure(.contactFetching)
            }
            
            contacts.append(contentsOf: contact)
        }
        return .success(contacts)
    }
    
    func validateNumber(_ number: String) -> String {
        var phoneNumber = number
        
        if phoneNumber.contains(" ") ||
            phoneNumber.contains("-") ||
            phoneNumber.contains("(") ||
            phoneNumber.contains(")") {
            
            phoneNumber = phoneNumber
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "-", with: "")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: "(", with: "")
        }
        
        let array = Array(phoneNumber)
        
        if let firstItem = array.first, firstItem == "8" {
            phoneNumber = "+7" + String(phoneNumber.dropFirst())
        }
        return phoneNumber
    }
}
