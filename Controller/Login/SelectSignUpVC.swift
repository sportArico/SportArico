

import UIKit

class SelectSignUpVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var btnCustomer: UIButton!
    @IBOutlet weak var btnProvider: UIButton!
    @IBOutlet weak var btnAlreadyAccount: UIButton!
    //=== End ===//
    
    //MARK: Variable
    var myStringCustomer:NSString = "Signup as a Customer"
    var myMutableStringCustomer = NSMutableAttributedString()
    var myStringProvider:NSString = "Signup as a Provider"
    var myMutableStringProvider = NSMutableAttributedString()
    var myStringAlreadyAccount:NSString = "Already have an account? LOGIN NOW"
    var myMutableAlreadyAccount = NSMutableAttributedString()
    //=== End ===//

    fileprivate func SetUpUI() {
        myMutableStringCustomer = NSMutableAttributedString(string: myStringCustomer as String, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)])
        myMutableStringCustomer.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location:12,length:8))
        myMutableStringCustomer.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:11))
        btnCustomer.setAttributedTitle(myMutableStringCustomer, for: .normal)
        myMutableStringProvider = NSMutableAttributedString(string: myStringProvider as String, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)])
        myMutableStringProvider.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location:12,length:8))
        myMutableStringProvider.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:11))
        btnProvider.setAttributedTitle(myMutableStringProvider, for: .normal)
        
        myMutableAlreadyAccount = NSMutableAttributedString(string: myStringAlreadyAccount as String, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15.0)])
        myMutableAlreadyAccount.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.black, range: NSRange(location:24,length:10))
        myMutableAlreadyAccount.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.white, range: NSRange(location:0,length:24))
        btnAlreadyAccount.setAttributedTitle(myMutableAlreadyAccount, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCustomer(_ sender: Any) {
        let storybord = UIStoryboard(name: "Login", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        VC.user_type = "5"
        navigationController?.pushViewController(VC, animated: true)
        //self.present(VC, animated: true, completion: nil)
    }
    @IBAction func btnProvider(_ sender: Any) {
        let storybord = UIStoryboard(name: "Login", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SignUpProviderVC") as! SignUpProviderVC
        navigationController?.pushViewController(VC, animated: true)
        //self.present(VC, animated: true, completion: nil)
    }
    @IBAction func btnAlreadyAccount(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
