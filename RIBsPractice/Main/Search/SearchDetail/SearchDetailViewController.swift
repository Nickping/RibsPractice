//
//  SearchDetailViewController.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs
import RxSwift
import UIKit

protocol SearchDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    
    func didTapAddFavorite(_ repoId: String)
    func didTapRemoveFavorite(_ repoId: String)
}

final class SearchDetailViewController: GeneralViewController, SearchDetailPresentable, SearchDetailViewControllable {

    weak var listener: SearchDetailPresentableListener?
    
    var repository: Repository?
    
    
    @IBAction func didTapFavoriteBtn(_ sender: Any) {
        guard let repo = repository else {
            return
        }
        listener?.didTapAddFavorite(String(repo.id))
    }
    @IBAction func didTapRemoveFavoriteBtn(_ sender: Any) {
        guard let repo = repository else {
            return
        }
        listener?.didTapRemoveFavorite(String(repo.id))
    }
}
