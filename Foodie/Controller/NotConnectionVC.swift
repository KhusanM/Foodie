//
//  notConnectionVC.swift
//  FoodieApp
//
//  Created by Alibek on 05/07/21.
//

import UIKit
import SnapKit

class NotConnectionVC: UIViewController {
    
    let image : UIImageView = {
        let i = UIImageView(image: UIImage(named: "wifi"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    let label : UILabel = {
        let l = UILabel()
        l.text = "No internet Connection"
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return l
    }()
    let label2 : UILabel = {
        let l = UILabel()
        l.text = "Your internet connection is currently not available please check or try again"
        l.numberOfLines = 2
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        l.textColor = .systemGray4
        return l
    }()
    
    let btn : UIButton = {
        let i = UIButton()
        i.setTitle("Try again", for: .normal)
        i.setTitleColor(.white, for: .normal)
        i.backgroundColor = .systemRed
        i.layer.cornerRadius = 35
        return i
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(image)
        self.view.addSubview(label)
        self.view.addSubview(label2)
        self.view.addSubview(btn)
        setupConstrains()

    }
    

    
    
    func setupConstrains(){
        
        image.snp.makeConstraints { (i) in
            i.top.equalToSuperview().offset(250)
            i.left.equalToSuperview().offset(130)
            i.right.equalToSuperview().offset(-130)
            i.height.equalTo(120)
            i.width.equalTo(120)
        }
        label.snp.makeConstraints { (l) in
            l.bottom.equalTo(image).offset(70)
            l.left.equalToSuperview().offset(47)
            l.right.equalToSuperview().offset(-47)
        }
        label2.snp.makeConstraints { (l) in
            l.bottom.equalTo(label).offset(50)
            l.left.equalToSuperview().offset(51)
            l.right.equalToSuperview().offset(-51)
        }
        btn.snp.makeConstraints { (b) in
            b.bottom.equalToSuperview().offset(-250)
            b.left.equalToSuperview().offset(50)
            b.right.equalToSuperview().offset(-50)
            b.height.equalTo(70)
        }
    }
    
}
