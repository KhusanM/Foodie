//
//  OrderVC.swift
//  Foodie
//
//  Created by Mirshod on 7/6/21.
//

import UIKit

class OrderVC: UIViewController {
    @IBOutlet var orderLbl: UILabel!
    
    @IBOutlet var orderBtn: UIButton!
    @IBOutlet var orderLabel: UILabel!
    @IBOutlet var uiImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func setTextLbael(){
        if UIScreen.main.bounds.height < 650 {
            orderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        }
    }

}
