//
//  RootViewController.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/11/29.
//

import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}


class GeneralViewController: UIViewController, GeneralViewControllable {
    func present(viewController: ViewControllable) {
        viewController.uiviewController.modalPresentationStyle = .fullScreen
        present(viewController.uiviewController, animated: false, completion: nil)
    }
    
    func present(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)
    }
    
    func dismiss(viewController: ViewControllable) {
        if presentedViewController == viewController.uiviewController {
            viewController.uiviewController.dismiss(animated: false, completion: nil)
        }
    }
    
    func addChild(viewController: ViewControllable) {
//        viewController.uiviewController
        self.addChildViewController(viewController.uiviewController)
        
        viewController.uiviewController.view.frame = self.view.bounds
        viewController.uiviewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(viewController.uiviewController.view)
        viewController.uiviewController.didMove(toParentViewController: self)
    }
    
    func detachChild(viewController: ViewControllable) {
        viewController.uiviewController.willMove(toParentViewController: nil)
        viewController.uiviewController.view.removeFromSuperview()
        viewController.uiviewController.removeFromParentViewController()
    }
    
    func push(viewController: ViewControllable) {
        self.navigationController?.pushViewController(viewController.uiviewController, animated: true)
    }
    
    func pop(viewController: ViewControllable) {
        if navigationController?.topViewController == viewController.uiviewController {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}

final class RootViewController: GeneralViewController, RootPresentable, RootViewControllable {
    
    weak var listener: RootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("")
    }
}


extension RootViewController: MainViewControllable {}
