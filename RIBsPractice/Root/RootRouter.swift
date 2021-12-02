//
//  RootRouter.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/11/29.
//

import RIBs

protocol RootInteractable: Interactable, MainListener, LoggedOutListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}


protocol GeneralViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
    
    func addChild(viewController: ViewControllable)
    
    func push(viewController: ViewControllable)
    
    func pop(viewController: ViewControllable)
}

protocol NavigationViewControllable: GeneralViewControllable {
    func present(viewController: UIViewController)
}


protocol RootViewControllable: NavigationViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}


final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    let mainBuilder: MainBuildable
    
    let loggedOutBuilder: LoggedOutBuildable
    
    var currentChild: Routing?
    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: RootInteractable,
         viewController: RootViewControllable,
         loggedInBuildable: MainBuildable,
         loggedOutBuildable: LoggedOutBuildable) {
        self.mainBuilder = loggedInBuildable
        self.loggedOutBuilder = loggedOutBuildable
        
        super.init(interactor: interactor, viewController: viewController)
        
        
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        routeToLoggedOut()
        
    }
    
    func cleanupViews() {
        
    }
    
    func detachCurrent() {
        if let current = currentChild as? ViewableRouting {
            self.viewController.dismiss(viewController: current.viewControllable)
            detachChild(current)
            currentChild = nil 
        }
        
    }
    
    func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        
        attachChild(loggedOut)
        
        
        self.viewController.present(viewController: loggedOut.viewControllable)
        
        self.currentChild = loggedOut
        
    }
    
    func routeToLogin(_ name: String, _ passwd: String) {
        detachCurrent()
        
        let mainRib = mainBuilder.build(withListener: interactor, userName: name)        
        
        
        self.viewController.present(viewController: UINavigationController(rootViewController: mainRib.viewControllable.uiviewController))
//        self.viewController.present(viewController: mainRib.viewControllable)
        
//        self.viewController.push(viewController: mainRib.viewControllable)
        attachChild(mainRib)
        self.currentChild = mainRib
        
    }
}
