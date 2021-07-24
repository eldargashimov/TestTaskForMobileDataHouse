//
//  ContactServiceProtocol.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/22/21.
//

import Contacts

protocol ContactServiceProtocol: AnyObject {
    
    func getContact() -> Result<[CNContact], ContactError>
    
    func validateNumber(_ number: String) -> String
}

