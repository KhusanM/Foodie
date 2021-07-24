//
//  SeeMoreVC.swift
//  Foodie
//
//  Created by Ahliddin on 7/6/21.
//

import UIKit
import SDWebImage
class SeeMoreVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        }
    }
    
    var itemDM: [ItemDM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Foods"
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItems = [rightButton]
        

    }
    @objc func addTapped(){
        dismiss(animated: true, completion: nil)
    }

    
}

extension SeeMoreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemDM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        cell.costLbl.text = "\(itemDM[indexPath.row].cost)"
        cell.lbl.text = itemDM[indexPath.row].name
        //cell.imageView.sd_setImage(with: URL(string: base_URL + itemDM[indexPath.row].photo[indexPath.row].url!), placeholderImage: #imageLiteral(resourceName: "ToyFaces_Tansparent_BG_29") )
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        print((view.frame.height+38)/3)
        return CGSize(width: (view.frame.width-30)/2, height: 321)
    }
    
}
