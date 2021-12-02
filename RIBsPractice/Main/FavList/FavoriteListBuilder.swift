//
//  FavoriteListBuilder.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs

protocol FavoriteListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FavoriteListComponent: Component<FavoriteListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol FavoriteListBuildable: Buildable {
    func build(withListener listener: FavoriteListListener) -> FavoriteListRouting
}

final class FavoriteListBuilder: Builder<FavoriteListDependency>, FavoriteListBuildable {

    override init(dependency: FavoriteListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FavoriteListListener) -> FavoriteListRouting {
        let component = FavoriteListComponent(dependency: dependency)
        let viewController = FavoriteListViewController()
        let interactor = FavoriteListInteractor(presenter: viewController)
        interactor.listener = listener
        return FavoriteListRouter(interactor: interactor, viewController: viewController)
    }
}
