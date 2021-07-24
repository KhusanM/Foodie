



import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var btn: UIButton!{
        didSet{
            btn.layer.cornerRadius = btn.bounds.height * 0.37
        }
    }
    @IBOutlet weak var heightForBtn: NSLayoutConstraint!{
        didSet{
            if UIScreen.main.bounds.height < 650{
                heightForBtn.constant = 50
            }
        }
    }
    @IBOutlet weak var lbl: UILabel!{
        didSet{
            if UIScreen.main.bounds.height < 650{
                lbl.font = UIFont.systemFont(ofSize: 40, weight: .bold)
            }
        }
    }
    @IBOutlet weak var heightForToys: NSLayoutConstraint!{
        didSet{
            if UIScreen.main.bounds.height < 650{
                heightForToys.constant = 300
            }
        }
    }
    
    @IBOutlet weak var topImgView: UIView!{
        didSet{
            topImgView.layer.cornerRadius = topImgView.bounds.height * 0.45
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.isHidden = true
    }

    @IBAction func getStartedPressed(_ sender: UIButton) {
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
     
    }
    

}
