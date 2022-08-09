//
//  BaseViewController.swift
//  MangaApp
//
//  Created by Павел Виноградов on 09.08.2022.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {

    var mainView: T {view as! T}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = T()

        // Do any additional setup after loading the view.
    }

}
