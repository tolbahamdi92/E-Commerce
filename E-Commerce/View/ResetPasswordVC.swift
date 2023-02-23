//
//  ResetPasswordVC.swift
//  E-Commerce
//
//  Created by Tolba Hamdi on 2/23/23.
//

import UIKit

class ResetPasswordVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    //MARK: - Life Cycle View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        setupShadow()
    }
}

//MARK: - Private Methods
extension ResetPasswordVC {
    private func setupShadow() {
        emailView.addShadow()
        sendBtn.addShadow()
    }
}
