//
//  SignUpVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit
import Combine

class SignUpVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    //MARK:- Properties
    private var cancelables = Set<AnyCancellable>()
    
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShadow()
        setupNavBar()
    }
    
    //MARK: - IBActions
    @IBAction func signUpBtnTapped(_ sender: UIButton) {
        signUpBtnActionTapped()
    }
    
    @IBAction func haveAccountTapped(_ sender: UITapGestureRecognizer) {
        gotoLoginVC()
    }
    
    
    @IBAction func googleBtnTapped(_ sender: UIButton) {
        googleSignInAction()
    }
    
    @IBAction func facebookBtnTapped(_ sender: UIButton) {
        facebookSignInAction()
    }
    
}

//MARK: - Private Methods
extension SignUpVC {
    private func setupShadow() {
        nameView.addShadow()
        emailView.addShadow()
        passwordView.addShadow()
        signUpBtn.addShadow()
    }
    
    private func setupNavBar() {
        self.title = ViewControllerTitle.signUp
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
        guard nameTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noName)
            return false
        }
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
    
    private func signUpBtnActionTapped() {
        if isEnteredData() && isValidData() {
            self.view.showLoader()
            UserManager.shared.signUp(name: nameTF.text!, email: emailTF.text!, password: passwordTF.text!)
                .sink { [weak self] error in
                    guard let self else {return}
                    self.view.hideLoader()
                    if case let .failure(error) = error {
                        self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                    }
                    self.showAlert(title: Alerts.successTitle, message: Alerts.signUpSuccess) { _ in
                        self.gotoHomeVC()
                    }
                } receiveValue: { _ in }
                .store(in: &cancelables)
        }
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
    
    private func gotoLoginVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func gotoHomeVC() {
        
    }
}
