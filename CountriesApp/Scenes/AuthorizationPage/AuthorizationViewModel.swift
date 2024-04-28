//
//  AuthorizationViewModel.swift
//  CountriesApp
//
//  Created by Bakar Kharabadze on 4/26/24.
//

import UIKit
import Security

protocol AuthorizationViewModelDelegate : AnyObject {
    func navigateToCountriesPage()
    func imageLoaded(_ image: UIImage)
    func navigateToImagePicker()
    func showError(with error: String)
}

final class AuthorizationViewModel {
    
    weak var delegate: AuthorizationViewModelDelegate?
    
    //MARK: - Methods
    func viewDidLoad() {
        loadImageFromDocuments()
        if let (username, password) = retrieveCredentialsFromKeychain() {
            delegate?.navigateToCountriesPage()
        }
    }
    
    func saveImageToDocuments(image: UIImage) {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageURL = documentsDirectory.appendingPathComponent("profileImage.png")
        guard let imageData = image.pngData() else { return }
        
        if fileManager.fileExists(atPath: imageURL.path) {
            do {
                try fileManager.removeItem(at: imageURL)
            } catch {
            }
        }
        
        do {
            try imageData.write(to: imageURL)
        } catch {
        }
    }
    
    func imageButtonTapped() {
        delegate?.navigateToImagePicker()
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
    
    func loginButtonDidTap(username: String?, password: String?, passwordCheck: String?) {
        guard let username, let password, let passwordCheck,
              !username.isEmpty, !password.isEmpty, !passwordCheck.isEmpty else {
            delegate?.showError(with: "ყველა ველი უნდა იყოს შეყვანილი")
            return
        }
        
        guard password == passwordCheck else {
            delegate?.showError(with: "შეიყვანეთ პაროლი სწორად")
            return
        }
        
        saveCredentialsToKeychain(username, password, passwordCheck)
        if !UserDefaults.standard.bool(forKey: "hasLoggedInBefore") {
            UserDefaults.standard.set(true, forKey: "isFirstLogin")
            UserDefaults.standard.set(true, forKey: "hasLoggedInBefore")
        } else {
            UserDefaults.standard.set(false, forKey: "isFirstLogin")
        }
        delegate?.navigateToCountriesPage()
    }
    
    private func loadImageFromDocuments() {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let imageURL = documentsDirectory.appendingPathComponent("profileImage.png")
        
        if fileManager.fileExists(atPath: imageURL.path) {
            if let imageData = try? Data(contentsOf: imageURL),
               let image = UIImage(data: imageData) {
                delegate?.imageLoaded(image)
            }
        }
    }
}
