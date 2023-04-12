//
//  UserDefaultsService.swift
//  MVVMDemo
//
//  Created by саргашкаева on 24.03.2023.
//

import UIKit

enum Authentication: String {
    case isLogged
}


protocol UserDefaultsServiceImplementation: AnyObject {
    var isLogged: Bool { get }
    func saveLoggedState(isLogged: Bool)
}

class UserDefaultsService: UserDefaultsServiceImplementation {
    
    private let storage: UserDefaults
    
    static let shared = UserDefaultsService()
    
    required init(storage: UserDefaults = UserDefaults.standard) {
        self.storage = storage
    }
    
    func saveLoggedState(isLogged: Bool) {
        storage.setValue(isLogged, forKey: Authentication.isLogged.rawValue)
        storage.synchronize()
    }
    
    var isLogged: Bool {
        return storage.value(forKey: Authentication.isLogged.rawValue) as? Bool ?? false
    }
}
