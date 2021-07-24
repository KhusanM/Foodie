//
//  OrderVC.swift
//  Foodie
//
//  Created by Mirshod on 7/6/21.
//

import UIKit
import Alamofire
import SwiftyJSON


class OrderVC: UIViewController {
    
    
    @IBOutlet weak var noOrdersStack: UIStackView!
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CartTVC", bundle: nil), forCellReuseIdentifier: "CartTVC")
            tableView.separatorStyle = .none
        }
    }
    
    var data = [ItemDM]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonTitle = ""
        title = "Orders"
        fetchData()
        if !data.isEmpty{
            noOrdersStack.isHidden = true
        }
    }
    
    func fetchData(){
        data = MyRealm.shared.fetchData()
        tableView.reloadData()
    }
    

    func setTextLbael(){
        if UIScreen.main.bounds.height < 650 {
            
        }
    }
    
}

extension OrderVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVC", for: indexPath) as! CartTVC
        cell.minusBtn.isHidden = true
        cell.plusBtn.isHidden = true
        cell.setTextLbael()
        cell.updateCell(item: data[indexPath.row])
        cell.uiImageView.sd_setImage(with: URL(string: base_URL + data[indexPath.row].photo[indexPath.row].url!), placeholderImage: #imageLiteral(resourceName: "loading") )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if UIScreen.main.bounds.height < 650 {
                self.tableView.rowHeight = 40
            }
        return CGFloat(100)
    }
}
