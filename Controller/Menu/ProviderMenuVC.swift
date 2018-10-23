

import UIKit
import KYDrawerController

class ProviderMenuVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tblMenu: UITableView!
    //=== End ===//
    
    //MARK: Variable
    var appTabBar: TabBarVC?
    var ArrayName:[String] = []
    var ArrayImages:[UIImage] = []
    var drawerVC:KYDrawerController?
    
    let storybord = UIStoryboard(name: "Main", bundle: nil)
    let Categorystorybord = UIStoryboard(name: "Category", bundle: nil)
    let Loginstorybord = UIStoryboard(name: "Login", bundle: nil)
    
    //var selectedCategory = UserDefaults.standard.value(forKey: "Category") as? String
    //let strIDs:[String] = (UserManager.shared.currentUser?.provider_categories.components(separatedBy: ","))!
    var strIDs:[String] = ["0"]
   
    
    //=== End ==//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ids = (UserManager.shared.currentUser?.provider_categories.components(separatedBy: ",")) as? [String]
        {
            strIDs = ids;
        }
        
        
        if strIDs.contains("1"){
            self.ArrayName.append("Court")
            self.ArrayImages.append(#imageLiteral(resourceName: "court_icon"))
        }
        if strIDs.contains("2"){
            self.ArrayName.append("Course")
            self.ArrayImages.append(#imageLiteral(resourceName: "training_icon"))
        }
        if strIDs.contains("3"){
            self.ArrayName.append("market")
            self.ArrayImages.append(#imageLiteral(resourceName: "market_icon"))
        }
        self.ArrayName.append("Logout")
        self.ArrayImages.append(#imageLiteral(resourceName: "log_out_icon"))
        tblMenu.delegate = self
        tblMenu.dataSource = self
        tblMenu.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension ProviderMenuVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return ArrayName.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell", for: indexPath) as! UserProfileCell
            cell.lblName.text = UserManager.shared.currentUser?.email
            cell.lblLocation.text = AppDelegate.sharedDelegate().location_name
            
            if let img = UserManager.shared.currentUser?.profile_image
            {
                cell.imgUserImage.sd_setImage(with: URL.init(string:img), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)                
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
            let obj = self.ArrayName[indexPath.row]
            let imgobj = self.ArrayImages[indexPath.row]
            cell.lblMenuName.text = obj
            cell.imgMenuImage.image = imgobj
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 120.0
        }else{
            return 50.0
        }
    }
    
    fileprivate func SelectedCategory(_ indexPath: IndexPath) {
        switch self.ArrayName[indexPath.row]{
        case "Court":
            self.APICallChangeCategory(user_Id: (UserManager.shared.currentUser?.user_id)!, category_Id: "1")
            break
        case "Course":
            self.APICallChangeCategory(user_Id: (UserManager.shared.currentUser?.user_id)!, category_Id: "2")
            break
        case "market":
            self.APICallChangeCategory(user_Id: (UserManager.shared.currentUser?.user_id)!, category_Id: "3")
            break
        default:
            drawerVC?.setDrawerState(.closed, animated: true)
            UserDefaults.standard.set(false, forKey: "IsLogin")
            let Loginstorybord = UIStoryboard(name: "Login", bundle: nil)
            let nav = Loginstorybord.instantiateViewController(withIdentifier: "navSignIn")
            AppDelegate.sharedDelegate().window?.rootViewController = nav
            AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblMenu.deselectRow(at: indexPath as IndexPath, animated: true)
        if let drawerController = self.parent as? KYDrawerController {
            drawerVC = drawerController
        }
        if indexPath.section == 0{
            let VC = storybord.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            present(VC, animated: true, completion: nil)
            drawerVC?.setDrawerState(.closed, animated: true)
        }
        else{
            SelectedCategory(indexPath)
        }
    }
}
extension ProviderMenuVC{
    func APICallChangeCategory(user_Id:String,category_Id:String) {
        ProviderManager.shared.ProviderChangeCategory(withID: user_Id, Category_id: category_Id, completion: { (isChange, error) in
            if isChange == true{
                if category_Id == "1"{
                    UserDefaults.standard.set("1", forKey: "Merchant_Category_Id")
                    UserManager.shared.currentUser?.category_id = "1"
                    self.drawerVC?.setDrawerState(.closed, animated: true)
                }
                else if category_Id == "2"{
                    UserDefaults.standard.set("2", forKey: "Merchant_Category_Id")
                    UserManager.shared.currentUser?.category_id = "2"
                    self.drawerVC?.setDrawerState(.closed, animated: true)
                }
                else if category_Id == "3"{
                    UserDefaults.standard.set("3", forKey: "Merchant_Category_Id")
                    UserManager.shared.currentUser?.category_id = "3"
                    self.drawerVC?.setDrawerState(.closed, animated: true)
                }
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        })
    }
}


