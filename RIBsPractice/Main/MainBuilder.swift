//
//  LoggedInBuilder.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs

protocol MainDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
//    var mainViewController: MainViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}



final class MainComponent: Component<MainDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.

    let mainViewController: MainViewController
    
    let userName: String

    init(dependency: MainDependency,
         userName: String,
         mainViewController: MainViewController) {
        self.mainViewController = mainViewController
        self.userName = userName
        super.init(dependency: dependency)
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}


extension MainComponent: SearchListDependency {
    
}

extension MainComponent: SearchDetailDependency {
    
}

// MARK: - Builder

protocol MainBuildable: Buildable {
    func build(withListener listener: MainListener,
               userName: String) -> MainRouting
}

final class MainBuilder: Builder<MainDependency>, MainBuildable {
    override init(dependency: MainDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MainListener,
               userName: String) -> MainRouting {
        
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController
        
        let component = MainComponent(dependency: dependency,
                                      userName: userName,
                                      mainViewController: mainViewController)
        let interactor = MainInteractor()
        
        let searchListBuilder = SearchListBuilder(dependency: component)
        let searchDetailBuilder = SearchDetailBuilder(dependency: component)
        
        interactor.listener = listener
        return MainRouter(interactor: interactor,
                          viewController: mainViewController,
                          searchListBuilder: searchListBuilder,
                          searchDetailBuilder: searchDetailBuilder)
    }
}
