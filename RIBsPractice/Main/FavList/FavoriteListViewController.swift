//
//  FavoriteListViewController.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs
import RxSwift
import UIKit

protocol FavoriteListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class FavoriteListViewController: UIViewController, FavoriteListPresentable, FavoriteListViewControllable {

    weak var listener: FavoriteListPresentableListener?
}
