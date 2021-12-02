//
//  RootBuilder.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/11/29.
//

import RIBs

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RootComponent: Component<RootDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    let rootViewController: RootViewController
    
    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

extension RootComponent: LoggedOutDependency {
    
}

extension RootComponent: MainDependency {
    
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
//        let viewController = RootViewController()
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootViewController") as! RootViewController
        
        
        let component = RootComponent(dependency: dependency,
                                      rootViewController: viewController)
        
            
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        
        let loggedInBuilder = MainBuilder(dependency: component)
        
        
        let interactor = RootInteractor(presenter: viewController)
        
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          loggedInBuildable: loggedInBuilder,
                          loggedOutBuildable: loggedOutBuilder)
    }
}
