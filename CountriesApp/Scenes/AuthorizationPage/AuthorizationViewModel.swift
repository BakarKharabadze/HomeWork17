//
//  AuthorizationViewModel.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/26/24.
//

import Foundation
import Security


protocol AuthorizationViewModelDelegate : AnyObject {
    func navigateToCountriesPage()
}

class AuthorizationViewModel {
    
    weak var delegate: AuthorizationViewModelDelegate?
    
    func viewDidLoad() {
        if let (username, password) = retrieveCredentialsFromKeychain() {
            print("Automatically logged in with username: \(username)")
            delegate?.navigateToCountriesPage()
        }
    }
    
    func saveCredentialsToKeychain(_ username: String, _ password: String, _ passwordCheck: String) {
        let passwordData = Data(password.utf8)
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: passwordData
        ]
        
        let attributes: [String: Any] = [
            kSecValueData as String: passwordData,
        ]
        
        if SecItemCopyMatching(query as CFDictionary, nil) == noErr {
            SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        } else {
            let addQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrAccount as String: username,
                kSecValueData as String: passwordData,
            ]
            SecItemAdd(addQuery as CFDictionary, nil)
        }
    }
    
    func retrieveCredentialsFromKeychain() -> (username: String, password: String)? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnData as String: true,
            kSecReturnAttributes as String: true
        ]
        
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8) {
                return (username, password)
            }
        }
        
        return nil
    }
    
    func removeCredentialsFromKeychain() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]
        SecItemDelete(query as CFDictionary)
    }
    
    func loginButtonDidTap(username: String, password: String, passwordCheck: String) {
        guard !username.isEmpty, !password.isEmpty, !passwordCheck.isEmpty else {
            return
        }
        guard password == passwordCheck else {
            return
        }
        
        saveCredentialsToKeychain(username, password, passwordCheck)
        if !UserDefaults.standard.bool(forKey: "hasLoggedInBefore") {
               UserDefaults.standard.set(true, forKey: "isFirstLogin")
               UserDefaults.standard.set(true, forKey: "hasLoggedInBefore")
           }
        
        delegate?.navigateToCountriesPage()
    }
}
