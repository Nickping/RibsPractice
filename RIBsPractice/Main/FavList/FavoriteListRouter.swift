//
//  FavoriteListRouter.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs

protocol FavoriteListInteractable: Interactable {
    var router: FavoriteListRouting? { get set }
    var listener: FavoriteListListener? { get set }
}

protocol FavoriteListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FavoriteListRouter: ViewableRouter<FavoriteListInteractable, FavoriteListViewControllable>, FavoriteListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FavoriteListInteractable, viewController: FavoriteListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
