//
//  UserManager.swift
//  TodoList
//
//  Created by Tolba Hamdi on 2/12/23.
//

import Foundation
import Combine
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

struct UserManager {
    //MARK:- Properties
    static let shared = UserManager()
    
    //MARK:- initializer
    private init(){}
    
    func signIn(email: String, password: String) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            if let error {
                subject.send(completion: .failure(error))
            }
                subject.send(completion: .finished)
        }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
    func signInWithFacebook(viewController: UIViewController) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        let loginManager = LoginManager()
                loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { (result, error) in
                    if let error = error {
                        subject.send(completion: .failure(error))
                    }
                    
                    guard let accessToken = result?.token else {
                        return
                    }

                    let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                    
                    // Perform login by calling Firebase APIs
                    Auth.auth().signIn(with: credential, completion: { (user, error) in
                        if let error = error {
                            subject.send(completion: .failure(error))
                        }else {
                            subject.send(completion: .finished)
                        }
                    })
                }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
    func signInWithGoogle(viewController: UIViewController) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
            if let error {
                subject.send(completion: .failure(error))
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                subject.send(completion: .failure(error!))
                return
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                if let error {
                    subject.send(completion: .failure(error))
                }
                subject.send(completion: .finished)
            }
        }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
    func forgotPassword(email: String) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error {
                subject.send(completion: .failure(error))
            }
                subject.send(completion: .finished)
        }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
    func signUp(name: String, email: String, password: String) -> AnyPublisher< Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error {
                subject.send(completion: .failure(error))
            } else {
                let changeRequest = result!.user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    if let error {
                        subject.send(completion: .failure(error))
                    }
                }
                subject.send(completion: .finished)
            }
        }
        return subject.handleEvents().eraseToAnyPublisher()
    }
    
    //MARK:- getCurrentUserID
    func getCurrentUserID() -> String? {
        Auth.auth().currentUser?.uid
    }
    
    //MARK:- getCurrentUserName
    func getCurrentUserName() -> String? {
        Auth.auth().currentUser?.displayName
    }
    
}
