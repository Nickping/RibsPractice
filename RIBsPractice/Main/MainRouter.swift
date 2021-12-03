//
//  LoggedInRouter.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import RIBs

protocol MainInteractable: Interactable, SearchListListener, SearchDetailListener {
    var router: MainRouting? { get set }
    var listener: MainListener? { get set }
}

protocol MainViewControllable: GeneralViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    
    
    // TODO: Constructor inject child builder protocols to allow building children.
    
    let searchListBuilder: SearchListBuildable
    
    let searchDetailBuilder: SearchDetailBuildable
    
    private var searchList: SearchListRouting?
    
    private var searchDetail: SearchDetailRouting?
    
    init(interactor: MainInteractable,
         viewController: MainViewControllable,
         searchListBuilder: SearchListBuildable,
         searchDetailBuilder: SearchDetailBuildable) {
        self.searchDetailBuilder = searchDetailBuilder
        self.searchListBuilder = searchListBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    
    
    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }
    
    override func didLoad() {
        super.didLoad()
     
        attachSearchList()
    }
    
    func routeToDetail(_ repository: Repository) {
//        detachCurrent()
        let searchDetail = searchDetailBuilder.build(withListener: interactor,
                                                     detailRepository: repository)
        self.searchDetail = searchDetail
        attachChild(searchDetail)

        
        viewController.push(viewController: searchDetail.viewControllable)
        
    }
    
    func attachSearchList() {
        let searchList = searchListBuilder.build(withListener: interactor)
        self.searchList = searchList
        attachChild(searchList)
        viewController.addChild(viewController: searchList.viewControllable)
        
    }
    
    func detachCurrent() {
        if let searchList = searchList {
            detachChild(searchList)
            viewController.dismiss(viewController: searchList.viewControllable)
        }
        
    }
    
}
