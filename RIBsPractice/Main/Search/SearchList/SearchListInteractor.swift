//
//  SearchListInteractor.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs
import RxSwift

protocol SearchListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchListPresentable: Presentable {
    var listener: SearchListPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    
    func didGetSearchResult()
    
    func didUpdateFavorite(_ repoId: [String: Bool])
}

protocol SearchListListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    
    func didSelect(_ repository: Repository)
}

final class SearchListInteractor: PresentableInteractor<SearchListPresentable>, SearchListInteractable, SearchListPresentableListener {
    var favoriteRepos: [String : Bool] = [:]
    
    weak var router: SearchListRouting?
    weak var listener: SearchListListener?
    
    var repoList: Observable<[Repository]> {
        return repoResults.asObservable()
    }
    
    private(set) var repos: [Repository] = []
    
    private var repoResults: PublishSubject<[Repository]>

    private var favoriteRepoStream: FavoriteRepoStream
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: SearchListPresentable,
         favoriteRepoStream: FavoriteRepoStream) {
        self.favoriteRepoStream = favoriteRepoStream
        repoResults = PublishSubject<[Repository]>()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    
    func subscribeFavoriteRepos() {
        self.favoriteRepoStream.favoriteRepos
            .debug()
            .subscribe { [weak self] (favorites) in
                self?.favoriteRepos = favorites
                self?.presenter.didUpdateFavorite(favorites)
            } onError: { (error) in
                
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposeOnDeactivate(interactor: self)

    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        subscribeFavoriteRepos()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    

    
    func search(_ keyword: String) {
        SearchApi.search(keyword, 0) { [weak self] (repos) in
            self?.repos = repos
            self?.presenter.didGetSearchResult()
            
            
        }
    }
    
    func didSelect(_ repository: Repository) {
        listener?.didSelect(repository)
    }
    

}
