//
//  ContactModel.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/22/21.
//

struct ContactModel {
    
    
    
    let name: String
    let lastName: String
    let phone: String?
    
    var validatePhone: String? {
        guard let phone = phone else { return nil }
        
        var phoneNumber = phone
        
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
