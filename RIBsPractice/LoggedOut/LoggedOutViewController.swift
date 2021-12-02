//
//  LoggedOutViewController.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs
import RxSwift
import UIKit

protocol LoggedOutPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func didTapLogin(_ name: String, passwd: String)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        guard let name = nameTextField.text, let passwd = passWordTextField.text else {
            return
        }
        listener?.didTapLogin(name, passwd: passwd)
    }
    
}
