//
//  CVC.swift
//  FoodieApp
//
//  Created by Alibek on 06/07/21.
//

import UIKit

class CVC: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    
    
    static func nib() -> UINib{
        UINib(nibName: "CVC", bundle: nil)
    }
    static let id : String = "CVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
