//
//  ResetPasswordVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit
import Combine

class ResetPasswordVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    //MARK:- Properties
    private var cancelables = Set<AnyCancellable>()
    
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShadow()
        setupNavBar()
    }
    
    //MARK: -
    
    @IBAction func sendBtnTapped(_ sender: UIButton) {
        sendBtnActionTapped()
    }
}

//MARK: - Private Methods
extension ResetPasswordVC {
    private func setupNavBar() {
        self.title = ViewControllerTitle.resetPassword
    }
    
    private func setupShadow() {
        emailView.addShadow()
        sendBtn.addShadow()
    }
    private func isValidData() -> Bool {
        guard ValidtionDataManager.shared.isValidEmail(email: emailTF.text!) else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.validEmail)
            return false
        }
        
        return true
    }
    
    private func isEnteredData() -> Bool {
        guard emailTF.text != "" else {
            showAlert(title: Alerts.sorryTitle, message: Alerts.noEmail)
            return false
        }
        return true
    }
    
    private func sendBtnActionTapped() {
        if isEnteredData() && isValidData() {
            self.view.showLoader()
            UserManager.shared.forgotPassword(email: emailTF.text!)
                .sink { [weak self] error in
                    guard let self else {return}
                    self.view.hideLoader()
                    if case let .failure(error) = error {
                        self.showAlert(title: Alerts.sorryTitle, message: error.localizedDescription)
                    }
                    self.showAlert(title: Alerts.successTitle, message: Alerts.sendEmail) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                } receiveValue: { _ in }
                .store(in: &cancelables)
        }
    }
}
