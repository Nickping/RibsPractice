//
//  MainViewController.swift
//  RIBsPractice
//
//  Created by Euijoon Jung on 2021/12/01.
//

import UIKit
import RIBs

protocol MainPresentableListener: AnyObject {
    
}

class MainViewController: GeneralViewController, MainPresentable, MainViewControllable {
    weak var listener: MainPresentableListener?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.navigationController)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.navigationController)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
