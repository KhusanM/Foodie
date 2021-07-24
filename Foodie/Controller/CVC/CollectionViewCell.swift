//
//  CollectionViewCell.swift
//  Foodie
//
//  Created by Ahliddin on 7/6/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var viewSahadow: UIView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //imageView.layer.cornerRadius = imageView.bounds.height * 0.4
        viewSahadow.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        viewSahadow.layer.shadowOffset = CGSize(width: 2 , height: 2)
        viewSahadow.layer.shadowOpacity = 0.5
        viewSahadow.layer.shadowRadius = 30
        
    }

}
