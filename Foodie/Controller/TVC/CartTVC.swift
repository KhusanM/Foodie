//
//  CartTVC.swift
//  Foodie
//
//  Created by Mirshod on 7/5/21.
//

import UIKit

class CartTVC: UITableViewCell {

    @IBOutlet weak var minusBtn: UIButton!
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
    var item : ItemDM?
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var sumLbl: UILabel!
    @IBOutlet var contextLbl: UILabel!
    @IBOutlet var uiImageView: UIImageView!{
        didSet{
            uiImageView.layer.cornerRadius = uiImageView.bounds.height * 0.38
        }
    }
    @IBOutlet var stack: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(item: ItemDM){
        self.item = item
        contextLbl.text = item.name
        self.count = item.count
        sumLbl.text = "#\(item.cost * item.count)"
        resultLbl.text = "\(item.count)"
        
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
        
        sum = count * item!.cost

        MyRealm.shared.setCount(item: item!, newCount: count)
        
    }
    
    @IBAction func plusBtnPressed(_ sender: Any) {
        count += 1
        sum = count * item!.cost
        MyRealm.shared.setCount(item: item!, newCount: count)
    }

}
