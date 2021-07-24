//
//  DeliciousFoodVC.swift
//  Foodie
//
//  Created by Kh's on 7/4/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import RealmSwift



class FoodDM {
    var isRed: Bool
    
    init(isRed: Bool) {
        self.isRed = isRed
    }
    
}


class DeliciousFoodVC: UIViewController {

    var food:FoodDM!
    var foodname:[FoodDM] = [
        FoodDM(isRed: true),
        FoodDM(isRed: false),
        FoodDM(isRed: false),
        FoodDM(isRed: false)
    ]
    
    
    var itemData :[ItemDM] = []
    var nameArr = [String]()
    
    @IBOutlet weak var heightForCVC: NSLayoutConstraint!{
        didSet{
            if UIScreen.main.bounds.height < 650 {
                heightForCVC.constant = 160
            }
        }
    }
    @IBOutlet weak var seeMoreBtn: UIButton!{
        didSet{
            if UIScreen.main.bounds.height < 650 {
                seeMoreBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            }
        }
    }
    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet weak var titleLbl: UILabel!{
        didSet{
            if UIScreen.main.bounds.height < 650 {
                titleLbl.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        }
}
    @IBOutlet weak var foodsCollection: UICollectionView!{
        didSet {
            foodsCollection.delegate = self
            foodsCollection.dataSource = self
            foodsCollection.register(UINib(nibName: "FoodsCell", bundle: nil), forCellWithReuseIdentifier: "FoodsCell")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.shouldRemoveShadow(true)
        let leftBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .done, target: self, action: #selector(menuBtnTapped))
        leftBtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        let rightBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "shopping-cart"), style: .done, target: self, action: #selector(korzinaBtnTapped))
        rightBtn.tintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        navigationItem.leftBarButtonItem = leftBtn
        navigationItem.rightBarButtonItem = rightBtn
        getCotegory()
        getDish(name: "foods")
        title = "Menu"
    }

    private func getCotegory(){
        let header : HTTPHeaders = ["Authorization" : Cache.getUserToken()]
        AF.request(base_URL+"/api/categories", method: .get, encoding: URLEncoding.queryString, headers: header).responseJSON { [self] response in
            let statusCode = response.response?.statusCode
            
            switch statusCode{
            case 200:
                if let d = response.data{
                    let jsonData = JSON(d)
                    let data = jsonData["data"]
                    
                    print(data, "name data")
                    for i in data.enumerated(){
                        nameArr.append(data[i.offset]["name"].stringValue)
                        
                        foodsCollection.reloadData()
                    }
                }
            case 401:
                print(response.error?.errorDescription)
            case 404:
                print(response.error?.errorDescription)
            default:
                break
            }
        }
    }
    private func getDish(name: String){
        let header : HTTPHeaders = ["Authorization" : Cache.getUserToken()]
        AF.request(base_URL+"/api/\(name)", method: .get, encoding: URLEncoding.queryString, headers: header).responseJSON { [self] response in
            let statusCode = response.response?.statusCode
            
            switch statusCode{
            case 200:
                if let d = response.data{
                    let jsonData = JSON(d)
                    let data = jsonData["data"]
                    
                    
                    //print(data)
                    for i in data.enumerated(){
                        let photoArr: List<PhotoDM> = List<PhotoDM>()
                        
                        
                        for j in data[i.offset]["photo"].arrayValue{
                            let p = PhotoDM()
                            p.url = j.stringValue
                            photoArr.append(p)
                        }
                        let item = ItemDM()
                        item._id = data[i.offset]["_id"].stringValue
                        item.cost = data[i.offset]["cost"].intValue
                        item.discription = data[i.offset]["discription"].stringValue
                        item.name = data[i.offset]["name"].stringValue
                        item.photo = photoArr
                        
                        itemData.append(item)
                        collectionView.reloadData()
                    }
                }
            case 401:
                print(response.error?.errorDescription)
            case 404:
                print(response.error?.errorDescription)
            default:
                break
            }
        }
    }
 
    @IBAction func seeMoreBtnTapped(_ sender: Any) {
      
        let vc = SeeMoreVC(nibName: "SeeMoreVC", bundle: nil)
        
        vc.itemDM = itemData
        
        present(vc, animated: true, completion: nil)

    }
    
    
    @objc func korzinaBtnTapped(){
        let vc = CartVC(nibName: "CartVC", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func menuBtnTapped(){
        let vc = SideMenuVC(nibName: "SideMenuVC", bundle: nil)
        vc.delegate = self
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        vc.modalPresentationStyle = .overFullScreen
        UIView.animate(withDuration: 1) {
            self.view.transform = CGAffineTransform(translationX: self.view.frame.width / 2, y: 0).scaledBy(x: 0.66, y: 0.66)
            self.conteinerView.layer.cornerRadius = 30
        }
        present(vc, animated: false, completion: nil)
    }
    
}
extension DeliciousFoodVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.foodsCollection{
            return nameArr.count
            
        }else{
            
            return itemData.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.foodsCollection{
            let cell = foodsCollection.dequeueReusableCell(withReuseIdentifier: "FoodsCell", for: indexPath) as! FoodsCell
            
            if foodname[indexPath.row].isRed {
                UIView.animate(withDuration: 0.5) {
                    cell.labelFoods.textColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)
                    cell.viewCell.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)
                }
            }else {
                cell.viewCell.backgroundColor = .clear
                cell.labelFoods.textColor = .gray
            }
            
            cell.labelFoods.text = nameArr[indexPath.row].capitalized
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.imageView.layer.cornerRadius = self.view.bounds.height * 0.07
            cell.lbl.text = itemData[indexPath.row].name
            cell.costLbl.text = "\(itemData[indexPath.row].cost)"
            if !itemData[indexPath.row].photo.isEmpty{
                cell.imageView.sd_setImage(with: URL(string: base_URL + itemData[indexPath.row].photo.first!.url!), placeholderImage: UIImage(named: "loading") )
            }
            
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.foodsCollection{
            return CGSize(width: 100, height: 40)
        }else{
            if UIScreen.main.bounds.height < 650{
                return CGSize(width: (self.view.bounds.width )  / 2 , height: self.view.bounds.width / 2)
            }else{
            return CGSize(width: (self.view.bounds.width )  / 1.8 , height: self.view.bounds.width / 1.6)
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView == self.foodsCollection{
            
            return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        }else{
            return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.foodsCollection{
            
            for i in foodname {
                i.isRed = false
            }
            foodname[indexPath.row].isRed = true
            if nameArr[indexPath.row] == "foods"{
                getDish(name: "foods")
                itemData.removeAll()
            }
            if nameArr[indexPath.row] == "snacks"{
                getDish(name: "snacks")
                itemData.removeAll()
            }
            if nameArr[indexPath.row] == "souces"{
                getDish(name: "souces")
                itemData.removeAll()
            }
            if nameArr[indexPath.row] == "drinks"{
                getDish(name: "drinks")
                itemData.removeAll()
            }
            
            foodsCollection.reloadData()
        }else{
            let vc = DescVC(nibName: "DescVC", bundle: nil)
            vc.item = itemData[indexPath.row]
            vc.navigationItem.backButtonTitle = "Back"
            vc.hidesBottomBarWhenPushed = true
            vc.navigationItem.backButtonTitle = ""
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension DeliciousFoodVC: MenuDelegate{
    func backTo() {
        UIView.animate(withDuration: 1) {

            self.view.transform = .identity
            self.conteinerView.layer.cornerRadius = 0
            self.navigationController?.navigationBar.isHidden = false
        }completion: { (_) in
            self.tabBarController?.tabBar.isHidden = false
        }
    }
}
