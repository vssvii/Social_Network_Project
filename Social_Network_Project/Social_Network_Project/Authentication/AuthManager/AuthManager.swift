//
//  AuthManager.swift
//  Social_Network_Project
//
//  Created by Developer on 16.02.2023.
//

import Foundation
import Firebase

class AuthManager {
    
    static let shared = AuthManager()
    
    private let auth = Auth.auth()
    
    private var verificationId: String?
    
    // MARK: Registration
    
    func startAuth (phoneNumber: String, completion: @escaping (Bool) -> Void) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                completion(false)
                return
            }
            self?.verificationId = verificationId
            completion(true)
        }
    }
    
    // MARK: get SMS Code
    
    func verifyCode (smsCode: String, completion: @escaping (Bool) -> Void) {
        
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: smsCode
        )
        
        auth.signIn(with: credential) { result, error in
            
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
