//
//  SearchDetailBuilder.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs

protocol SearchDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchDetailComponent: Component<SearchDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchDetailBuildable: Buildable {
    func build(withListener listener: SearchDetailListener,
               detailRepository: Repository) -> SearchDetailRouting
}

final class SearchDetailBuilder: Builder<SearchDetailDependency>, SearchDetailBuildable {

    override init(dependency: SearchDetailDependency) { 
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchDetailListener,
               detailRepository: Repository) -> SearchDetailRouting {
        let component = SearchDetailComponent(dependency: dependency)
//        let viewController = SearchDetailViewController()
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SearchDetailViewController") as! SearchDetailViewController
        
        viewController.repository = detailRepository
        let interactor = SearchDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchDetailRouter(interactor: interactor, viewController: viewController)
    }
}
