//
//  LoggedInInteractor.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs
import RxSwift

protocol MainRouting: ViewableRouting {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    
    func routeToDetail(_ repository: Repository)
}

protocol MainPresentable: Presentable {
    var listener: MainPresentableListener? { get set }
}

protocol MainListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class MainInteractor: Interactor, MainInteractable {
    weak var router: MainRouting?
    weak var listener: MainListener?

    private let stream: MutableFavoriteRepoStream
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(_ favoriteStream: MutableFavoriteRepoStream) {
        self.stream = favoriteStream
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func didSelect(_ repository: Repository) {
        router?.routeToDetail(repository)
    }
    
    func didTapRemoveFavorite(_ repoId: String) {
        stream.updateFavoriteRepos(false, repoId)
    }
    
    func didTapAddFavorite(_ repoId: String) {
        stream.updateFavoriteRepos(true, repoId)
        
    }
    
}
