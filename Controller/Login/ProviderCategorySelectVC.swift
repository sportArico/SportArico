

import UIKit
import KRProgressHUD
import KYDrawerController

class ProviderCategorySelectVC: UIViewController {

    @IBOutlet weak var btnCourt: UIButton!
    @IBOutlet weak var btnMarket: UIButton!
    @IBOutlet weak var btnTraining: UIButton!
    var Category_ID = "";
    
    var userData: NSDictionary?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnCourt.imageView?.contentMode = .scaleAspectFit
        btnMarket.imageView?.contentMode = .scaleAspectFit
        btnTraining.imageView?.contentMode = .scaleAspectFit
        btnMarket.backgroundColor = UIColor.lightGray
        btnTraining.backgroundColor = UIColor.lightGray
        btnCourt.cornerRadius = btnCourt.layer.frame.height / 2
        btnCourt.clipsToBounds = true
        btnMarket.cornerRadius = btnMarket.layer.frame.height / 2
        btnMarket.clipsToBounds = true
        btnTraining.cornerRadius = btnTraining.layer.frame.height / 2
        btnTraining.clipsToBounds = true
        
        
    }

    @IBAction func btnCourt(_ sender: Any) {
        
        if !btnCourt.isSelected
        {
            btnCourt.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
            btnCourt.isSelected = true
        }
        else
        {
            btnCourt.backgroundColor = UIColor.lightGray
            btnCourt.isSelected = false
        }
        
        //        btnMarket.backgroundColor = UIColor.lightGray
        //        btnTraining.backgroundColor = UIColor.lightGray
        self.Category_ID = "1"
    }
    @IBAction func btnMarket(_ sender: Any) {
        
        if !btnMarket.isSelected
        {
            btnMarket.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
            btnMarket.isSelected = true
        }
        else
        {
            btnMarket.backgroundColor = UIColor.lightGray
            btnMarket.isSelected = false
        }
        
        
        //        btnMarket.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
        //        btnCourt.backgroundColor = UIColor.lightGray
        //        btnTraining.backgroundColor = UIColor.lightGray
        self.Category_ID = "3"
    }
    @IBAction func btnTraining(_ sender: Any) {
        
        if !btnTraining.isSelected
        {
            btnTraining.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
            btnTraining.isSelected = true
        }
        else
        {
            btnTraining.backgroundColor = UIColor.lightGray
            btnTraining.isSelected = false
        }
        
        //        btnTraining.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
        //        btnCourt.backgroundColor = UIColor.lightGray
        //        btnMarket.backgroundColor = UIColor.lightGray
        self.Category_ID = "2"
    }
    @IBAction func onSignupFunc(_ sender: UIButton) {
        
        if !btnCourt.isSelected && !btnTraining.isSelected && !btnMarket.isSelected{
            Utility.setAlertWith(title: "Alert", message: "Please select one category to continue with sportarico.", controller: self)
            return
        }
        var param:[String:String] = [:]

        var cate = ""
        if btnCourt.isSelected
        {
            cate = "1,"
        }
        if btnTraining.isSelected
        {
            cate = cate +  "2,"
        }
        if btnMarket.isSelected
        {
            cate = cate +  "3,"
        }
        
        cate.removeLast()
        param["category_id"] = cate;
        param["user_id"] = userData?.value(forKey: "user_id") as! String
         self.APICallProvierCategory(param: param)
    }
    
    @IBAction func onbackFunc(_ sender: UIButton) {
         //self.navigationController?.popViewController(animated: true)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}


extension ProviderCategorySelectVC{
    
    
    func APICallProvierCategory(param:[String:String]) {
        
         KRProgressHUD.show()
        print(param)
        
        UserManager.shared.ProviderCategory(withParametrs: param) { (success, userData, error) in
         
            KRProgressHUD.dismiss()
            
            if success == true{
                let alert  = UIAlertController(title: "Success", message: "\(error ?? "")", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    
                    
                    
                    UserManager.shared.login(withEmail: "\(UserDefaults.standard.value(forKey: "emailsave")!)", password: "\(UserDefaults.standard.value(forKey: "passwordsave")!)", FCM_Token: "", email_phone : "email" ,isremember: true) { (User, error) in
                        if error != nil{
                            Utility.setAlertWith(title: "Error", message: error, controller: self)
                        }
                        else{
                           
                            let storybord = UIStoryboard(name: "Provider", bundle: nil)
                            let storyBoardSlideMenu = UIStoryboard(name: "Menu", bundle: nil)
                            guard let tabBarVC = storybord.instantiateViewController(withIdentifier: "ProviderHomeVC") as? ProviderHomeVC,
                                let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                                    withIdentifier: "ProviderMenuVC") as? ProviderMenuVC else {
                                        return
                            }
                            let mainViewController   = tabBarVC
                            let drawerViewController = slideMenuViewController
                            let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
                            drawerController.mainViewController = UINavigationController.init(rootViewController: mainViewController)
                            drawerController.drawerViewController = drawerViewController
                            AppDelegate.sharedDelegate().window?.rootViewController = drawerController
                            AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
                            
                        }
                    }
                    
                    
                    
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }            
        }
        
        UserManager.shared.signUpProvider(withParametrs: param, avatar: nil) { (isRegister, userData,error) in
            
         KRProgressHUD.dismiss()
            
            if isRegister == true{
                let alert  = UIAlertController(title: "Success", message: "\(error ?? "")", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    
                    let storybord = UIStoryboard(name: "Login", bundle: nil)
                    let VC = storybord.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
                    VC.userData = userData
                    self.present(VC, animated: true, completion: nil)
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
}
    
}

