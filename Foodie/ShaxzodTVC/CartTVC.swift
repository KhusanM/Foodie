//
//  CartTVC.swift
//  Foodie
//
//  Created by Mirshod on 7/5/21.
//

import UIKit

class CartTVC: UITableViewCell {

    @IBOutlet var plusBtn: UIButton!
    @IBOutlet var resultLbl: UILabel!
    var count = 1 {
        didSet{
            resultLbl.text! = "\(count)"
        }
    }
    var sum = 1900{
        didSet{
            sumLbl.text! = "#\(sum)"
        }
    }
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var sumLbl: UILabel!
    @IBOutlet var contextLbl: UILabel!
    @IBOutlet var uiImageView: UIImageView!
    @IBOutlet var stack: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func setTextLbael(){
        if UIScreen.main.bounds.height < 650 {
            contextLbl.font = UIFont.systemFont(ofSize: 11)
            sumLbl.font = UIFont.systemFont(ofSize: 12)
            plusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            
        }
    }
    @IBAction func minusBtnPressed(_ sender: Any) {
        if count > 1 {
            count -= 1
        }
        if sum > 1900{
            sum = sum / 2
        }
    }
    @IBAction func plusBtnPressed(_ sender: Any) {
        count += 1
        sum = sum * 2
    }

}
