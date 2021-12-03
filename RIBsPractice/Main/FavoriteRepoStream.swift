//
//  File.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/03.
//

import Foundation
import RxSwift

protocol FavoriteRepoStream: AnyObject {
    var favoriteRepos: Observable<[String: Bool]> { get }
}

protocol MutableFavoriteRepoStream: FavoriteRepoStream {
    func updateFavoriteRepos(_ add: Bool, _ repoId: String)
}

class FavoriteRepoStreamImpl: MutableFavoriteRepoStream {
    
    
    private let repoSubject: BehaviorSubject<[String: Bool]>
    
    init(_ initialValue: [String: Bool]) {
        repoSubject = BehaviorSubject<[String: Bool]>(value: initialValue)
    }
    
    var favoriteRepos: Observable<[String: Bool]> {
        return repoSubject.asObservable()
            .distinctUntilChanged()
    }
    
    func updateFavoriteRepos(_ add: Bool, _ repoId: String) {
        guard let existedRepos = try? repoSubject.value() else { return }
        
        var tempRepos: [String: Bool] = existedRepos
        tempRepos[repoId] = add ? true : nil
        repoSubject.onNext(tempRepos)
    }
}
