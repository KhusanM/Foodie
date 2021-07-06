//
//  CartVC.swift
//  Foodie
//
//  Created by Mirshod on 7/5/21.
//

import UIKit

class CartVC: UIViewController {
  
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CartTVC", bundle: nil), forCellReuseIdentifier: "CartTVC")
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

}
extension CartVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vc = tableView.dequeueReusableCell(withIdentifier: "CartTVC", for: indexPath) as! CartTVC
        vc.setTextLbael()
        return vc
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if UIScreen.main.bounds.height < 650 {
                self.tableView.rowHeight = 40
            }
        return CGFloat(100)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let image: UIImageView = {
//            let i = UIImageView()
//            i.image = UIImage(named: "ellip")
//            i.contentMode = .scaleAspectFit
//            i.translatesAutoresizingMaskIntoConstraints = false
//            return i
//        }()
//        let image1: UIImageView = {
//            let i = UIImageView()
//            i.image = UIImage(named: "Vector")
//            i.contentMode = .scaleAspectFit
//            i.translatesAutoresizingMaskIntoConstraints = false
//            return i
//        }()
        
        let v1 = UIView()
        v1.backgroundColor = .systemGray6
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
        // Perform your action here
          completion(true)
      }
        let heartAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
        // Perform your action here
          completion(true)
      }
        

//            view.addSubview(v1)
//
//            v1.translatesAutoresizingMaskIntoConstraints = false
//            v1.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//            v1.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//            v1.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//            v1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//
//            v1.addSubview(image)
//            v1.addSubview(image1)
//
//            image.topAnchor.constraint(equalTo: v1.topAnchor, constant: 15).isActive = true
//            image.bottomAnchor.constraint(equalTo: v1.bottomAnchor, constant: -15).isActive = true
//            image.rightAnchor.constraint(equalTo: v1.rightAnchor, constant: -15).isActive = true
//            image.leadingAnchor.constraint(equalTo: v1.leadingAnchor, constant: 15).isActive = true
//
//            image1.topAnchor.constraint(equalTo: v1.topAnchor, constant: 26).isActive = true
//            image1.bottomAnchor.constraint(equalTo: v1.bottomAnchor, constant: -26).isActive = true
//            image1.rightAnchor.constraint(equalTo: v1.rightAnchor, constant: -26).isActive = true
//            image1.leadingAnchor.constraint(equalTo: v1.leadingAnchor, constant: 26).isActive = true
        
            
        
        heartAction.image = UIImage(named: "heart")
        heartAction.backgroundColor = UIColor.systemGray6
        
    
        
        deleteAction.image = UIImage(named: "trash")
    
        deleteAction.backgroundColor = UIColor.systemGray6
        
      
      return UISwipeActionsConfiguration(actions: [deleteAction,heartAction])
    }
    
}
