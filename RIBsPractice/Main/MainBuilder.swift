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
    
    let repoIds: [String: Bool]
    
    var favoriteRepoIds: [String: Bool] {
        return repoIds
    }
    
    var mutableFavoriteRepos: FavoriteRepoStreamImpl {
        return shared({ FavoriteRepoStreamImpl( favoriteRepoIds )})
    }
    
    init(dependency: MainDependency,
         userName: String,
         mainViewController: MainViewController,
         favoriteRepoIds: [String]) {
        self.mainViewController = mainViewController
        self.userName = userName
        
        var repos: [String: Bool] = [:]
        favoriteRepoIds.forEach({ repos[$0] = true })
        self.repoIds = repos
        super.init(dependency: dependency)
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}


extension MainComponent: SearchListDependency {
    
//    var favoriteRepoIds: [String] {
//        return repoIds
//    }
//
//    var mutableFavoriteRepos: FavoriteRepoStreamImpl {
//        return shared({ FavoriteRepoStreamImpl( favoriteRepoIds )})
//    }
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
                                      mainViewController: mainViewController,
                                      favoriteRepoIds: ["434380510"])
        
        
        
//        let interactor = MainInteractor(["33569135", "434380510"])
        let interactor = MainInteractor(component.mutableFavoriteRepos)
        
        let searchListBuilder = SearchListBuilder(dependency: component)
        let searchDetailBuilder = SearchDetailBuilder(dependency: component)
        
        interactor.listener = listener
        return MainRouter(interactor: interactor,
                          viewController: mainViewController,
                          searchListBuilder: searchListBuilder,
                          searchDetailBuilder: searchDetailBuilder)
    }
}
