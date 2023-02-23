//
//  SignUpVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShadow()
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
}
