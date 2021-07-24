//
//  ContactError.swift
//  MobileDataHouseTestTask
//
//  Created by Mac on 7/22/21.
//

enum ContactError: Error {
    
    case containersFetching
    case contactFetching
    
    var descriptionForUser: String {
        switch self {
        case .contactFetching:
            return "Не получилось взять контакты"
        
        case .containersFetching:
            return "Извините что-то пошло не так"
        }
    }
}
