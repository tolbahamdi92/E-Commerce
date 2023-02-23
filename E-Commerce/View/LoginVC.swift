//
//  LoginVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShadow()
    }
}

//MARK: - Private Methods
extension LoginVC {
    private func setupShadow() {
        emailView.addShadow()
        passwordView.addShadow()
        loginBtn.addShadow()
    }
}
