//
//  SearchListBuilder.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs

protocol SearchListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    
    var favoriteRepoIds: [String: Bool] { get }
    
    var mutableFavoriteRepos: FavoriteRepoStreamImpl { get }
}

final class SearchListComponent: Component<SearchListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchListBuildable: Buildable {
    func build(withListener listener: SearchListListener) -> SearchListRouting
}

final class SearchListBuilder: Builder<SearchListDependency>, SearchListBuildable {

    override init(dependency: SearchListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchListListener) -> SearchListRouting {
        let component = SearchListComponent(dependency: dependency)
     
        
//        let viewController = SearchListViewController()
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchListViewController") as! SearchListViewController
        let interactor = SearchListInteractor(presenter: viewController,
                                              favoriteRepoStream: component.dependency.mutableFavoriteRepos)
        interactor.listener = listener
        return SearchListRouter(interactor: interactor, viewController: viewController)
    }
}
