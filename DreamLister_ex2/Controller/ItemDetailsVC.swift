//
//  ItemDetailsVC.swift
//  DreamLister_ex2
//
//  Created by vriz on 2018. 6. 28..
//  Copyright © 2018년 vriz. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topItem = navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }
}
