//
//  descVC.swift
//  FoodieApp
//
//  Created by Alibek on 05/07/21.
//

import UIKit

class DescVC: UIViewController {

    @IBOutlet weak var pageContr: UIPageControl!
    
    @IBOutlet weak var addCarBtn: UIButton!
    var a: [UIColor] = [.red,.black,.green,.systemPink]
    
    @IBOutlet weak var myCollectionView: UICollectionView!{
        didSet{
            myCollectionView.delegate = self
            myCollectionView.dataSource = self
            myCollectionView.register(CVC.nib(), forCellWithReuseIdentifier: CVC.id)
            myCollectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        addCarBtn.layer.cornerRadius = 30
        addCarBtn.clipsToBounds = true
    }
}
extension DescVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as! CVC
        cell.contentView.backgroundColor = a[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (myCollectionView.bounds.width-20), height: 200)
        return cellSize
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("did",indexPath.item)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print(indexPath.item)
//        pageContr.currentPage = indexPath.item-1
//    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        print("ofset",scrollView.contentOffset.x)
        print("width",scrollView.frame.width)
        pageContr?.currentPage = Int(round((scrollView.contentOffset.x) / scrollView.frame.width))
    }


}
