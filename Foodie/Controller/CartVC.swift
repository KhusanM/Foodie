//
//  CartVC.swift
//  Foodie
//
//  Created by Mirshod on 7/5/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class CartVC: UIViewController {
  
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CartTVC", bundle: nil), forCellReuseIdentifier: "CartTVC")
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        }
    }
    
    var data = [ItemDM]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
    }
    
    func fetchData(){
        data = MyRealm.shared.fetchData()
        
        tableView.reloadData()
    }
    
    @IBAction func orderBtnTapped(_ sender: Any) {
        DoneAlert.showAlert(title: "Done!")
        
        if !data.isEmpty{
//            AF.request(base_URL+"/api/order", method: .post, parameters: ["order" : data], encoding: URLEncoding.queryString).responseJSON { (response) in
//                ///let result = response.result
//
//                if let d = response.data{
//                    let jsonData = JSON(d)
//                    print(jsonData["data"])
//                }
//            }
            
            
        }
    }
    

}
extension CartVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVC", for: indexPath) as! CartTVC
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
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let v1 = UIView()
        v1.backgroundColor = .systemGray6
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
        
            MyRealm.shared.deleteItem(item: self.data[indexPath.row])
            self.data.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            
          completion(true)
      }
        let heartAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
        // Perform your action here
          completion(true)
      }
        
        heartAction.image = UIImage(named: "heart")
        heartAction.backgroundColor = UIColor.systemGray6
        
    
        
        deleteAction.image = UIImage(named: "trash")
    
        deleteAction.backgroundColor = UIColor.systemGray6
        
      
      return UISwipeActionsConfiguration(actions: [deleteAction,heartAction])
    }
    
}
