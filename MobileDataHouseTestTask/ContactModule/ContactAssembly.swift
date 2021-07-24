//
//  ContactAssembly.swift
//  MobileDataHouseTestTask
//
//  Created by Максим Стегниенко on 23.07.2021.
//

import Contacts
import UIKit.UIViewController

final class ContactAssembly {
    
    static func createModule() -> UIViewController {
        let fetchKeys: [CNKeyDescriptor] = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]
        
        let service = ContactService(
            store: CNContactStore(),
            fetchKeys: fetchKeys
        )
        
        let interactor = ContactInteractor(service: service)
        let presenter = ContactPresenter(interactor: interactor)
        let vc = ContactsViewController()
        
        vc.presenter = presenter
        presenter.view = vc
        interactor.presenter = presenter
        
        return vc
    }
}
