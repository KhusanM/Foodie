//
//  descVC.swift
//  FoodieApp
//
//  Created by Alibek on 05/07/21.
//

import UIKit
import SwiftyJSON
import Alamofire
import SDWebImage
import RealmSwift

class DescVC: UIViewController {

    @IBOutlet weak var pageContr: UIPageControl!
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var addCarBtn: UIButton!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    var a: [UIColor] = [.red,.black,.green,.systemPink]
    
    @IBOutlet weak var myCollectionView: UICollectionView!{
        didSet{
            myCollectionView.delegate = self
            myCollectionView.dataSource = self
            myCollectionView.register(CVC.nib(), forCellWithReuseIdentifier: CVC.id)
            myCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        }
    }
    
    var item :ItemDM?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        addCarBtn.layer.cornerRadius = 30
        addCarBtn.clipsToBounds = true
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let item = item{
            nameLbl.text = item.name
            costLbl.text = "\(item.cost)"
            descLbl.text = item.discription
            pageContr.numberOfPages = item.photo.count
        }
    }
    
    
    @IBAction func addCardBtnTapped(_ sender: Any) {
        if let item = item{
            MyRealm.shared.saveItems(item: item)
            addCarBtn.backgroundColor = .systemGreen
        }
    }
    
    
}
extension DescVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item!.photo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as! CVC
        
        cell.img.sd_setImage(with: URL(string: base_URL + item!.photo[indexPath.row].url!), placeholderImage: UIImage(named: "loading") )
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (myCollectionView.bounds.width-20), height: 200)
        return cellSize
    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageContr?.currentPage = Int(round((scrollView.contentOffset.x) / scrollView.frame.width))
    }


}
