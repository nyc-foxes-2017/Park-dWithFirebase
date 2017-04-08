//
//  AuthProvider.swift
//  Park-dFirebasePods
//
//  Created by Sophia Pignatelli on 4/8/17.
//  Copyright © 2017 Sophia Pignatelli. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias  LoginHandler = (_ msg: String?) -> Void;

struct LoginErrorCode {
    static let INVALID_EMAIL = "Invalid email, please provide a real email address";
    static let WRONG_PASSWORD = "Wrong Password, Please Try Again";
    static let PROBLEM_CONNECTING = "Problem Connecting to Database. Please Try Later";
    static let USER_NOT_FOUND = "User Not Found, Please Register";
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Use Different Email";
    static let WEAK_PASSWORD = "Password Should Be At Least 6 Characters";
}

class AuthProvider {
    private static let _instance = AuthProvider();
    
    static var Instance: AuthProvider {
        return _instance;
    }
    
    func login(withEmail: String, password: String, loginHandler: LoginHandler?) {
        FIRAuth.auth()?.signIn(withEmail: withEmail, password: password, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
            } else {
                loginHandler?(nil);
            }
        })
    } //login func
    
    func signUp(withEmail: String, password: String, loginHandler: LoginHandler?) {
        FIRAuth.auth()?.createUser(withEmail: withEmail, password: password, completion: { (user, error) in
            if error != nil {
                self.handleErrors(err: error as! NSError, loginHandler: loginHandler);
            } else {
                if user?.uid != nil {
                    // store the user to database
                    //log in the user
                    self.login(withEmail: withEmail, password: password, loginHandler: loginHandler)
                }
            }
        })
        
    } //sign up func
    
    func logOut() -> Bool {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut();
                return true;
            } catch {
                return false;
            }
        }
        return true
    }
    
    private func handleErrors(err: NSError, loginHandler: LoginHandler?) {
        if let errCode = FIRAuthErrorCode(rawValue: err.code) {
            switch errCode {
            case .errorCodeWrongPassword:
                loginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
            case .errorCodeInvalidEmail:
                loginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
            case .errorCodeUserNotFound:
                loginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
            case .errorCodeEmailAlreadyInUse:
                loginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                break;
            case .errorCodeWeakPassword:
                loginHandler?(LoginErrorCode.WEAK_PASSWORD);
                break;
            default:
                loginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
            }
        }
    }
} //class
