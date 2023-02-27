//
//  LoginVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit
import Combine
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    //MARK:- Properties
    private var cancelables = Set<AnyCancellable>()
    
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShadow()
    }
    
    //MARK: - IBActions
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        signInBtnActionTapped()
    }
    
    @IBAction func forgetPasswordTapped(_ sender: UITapGestureRecognizer) {
        gotoResetPasswordVC()
    }
    
    @IBAction func haventAccountTapped(_ sender: UITapGestureRecognizer) {
        gotoSignUpVC()
    }
    
    @IBAction func googleBtnTapped(_ sender: UIButton) {
        googleSignInAction()
    }
    
    @IBAction func facebookBtnTapped(_ sender: UIButton) {
        facebookSignInAction()
    }
    
}

//MARK: - Private Methods
extension LoginVC {
    private func setupShadow() {
        setupNavBar()
        emailView.addShadow()
        passwordView.addShadow()
        loginBtn.addShadow()
    }
    
    private func setupNavBar() {
        self.title = ViewControllerTitle.login
    }
    
    private func isValidData() -> Bool {
        guard ValidtionDataManager.shared.isValidEmail(email: emailTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validEmail)
            return false
        }
        guard ValidtionDataManager.shared.isValidPassword(password: passwordTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validPassword)
            return false
        }
        return true
    }
    
    private func isEnteredData() -> Bool {
        guard emailTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noEmail)
            return false
        }
        guard passwordTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noPassword)
            return false
        }
        return true
    }
    
    private func signInBtnActionTapped() {
        if isEnteredData() && isValidData() {
            self.view.showLoader()
            UserManager.shared.signIn(email: emailTF.text!, password: passwordTF.text!)
                .sink { [weak self] error in
                    guard let self else {return}
                    self.view.hideLoader()
                    if case let .failure(error) = error {
                        self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                    }
                    self.showAlert(title: Alerts.successTitle, message: Alerts.signInSuccess) { _ in
                        self.gotoHomeVC()
                    }
                } receiveValue: { _ in }
                .store(in: &cancelables)
        }
    }
    
    private func googleSignInAction() {
        UserManager.shared.signInWithGoogle(viewController: self).sink { [weak self] error in
            guard let self else {return}
            if case let .failure(error) = error {
                self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
            }
            self.showAlert(title: Alerts.successTitle, message: Alerts.signInSuccess) { _ in
                self.gotoHomeVC()
            }
        } receiveValue: { _ in }
            .store(in: &cancelables)
    }
    
    private func facebookSignInAction() {
        UserManager.shared.signInWithFacebook(viewController: self).sink { [weak self] error in
            guard let self else {return}
            if case let .failure(error) = error {
                self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
            }
            self.showAlert(title: Alerts.successTitle, message: Alerts.signInSuccess) { _ in
                self.gotoHomeVC()
            }
        } receiveValue: { _ in }
            .store(in: &cancelables)
    }
    
    private func gotoHomeVC() {
        let tabBarControll = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.tabBarControll)
        present(tabBarControll, animated: true)
        
    }
    
    private func gotoResetPasswordVC() {
        let resetPasswordVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.resetPasswordVC)
        self.navigationController?.pushViewController(resetPasswordVC, animated: true)
    }
    
    private func gotoSignUpVC() {
        let signUpVC = UIStoryboard(name: StoryBoard.main, bundle: nil).instantiateViewController(withIdentifier: ViewController.signUpVC)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
