

import UIKit
import KYDrawerController

class MenuVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tblMenu: UITableView!
    //=== End ===//
    
    //MARK: Variable
    var appTabBar: TabBarVC?
    var ArrayName:[String] = ["Home","Favorite","Location","Notifications","Main Menu","Bookmarks","Settings","Logout"]
    var ArrayImages:[UIImage] = [#imageLiteral(resourceName: "home_icon"),#imageLiteral(resourceName: "favourite_icon"),#imageLiteral(resourceName: "location_icon"),#imageLiteral(resourceName: "noti_icon"),#imageLiteral(resourceName: "main_menu_icon"),#imageLiteral(resourceName: "bookmark_icon"),#imageLiteral(resourceName: "settings_icon"),#imageLiteral(resourceName: "log_out_icon")]
    
    let storybord = UIStoryboard(name: "Main", bundle: nil)
    let Categorystorybord = UIStoryboard(name: "Category", bundle: nil)
    let Loginstorybord = UIStoryboard(name: "Login", bundle: nil)
    
    var selectedCategory = UserDefaults.standard.value(forKey: "Category") as! String
    //=== End ==//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
extension MenuVC:UITableViewDataSource,UITableViewDelegate{
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
                cell.imgUserImage.sd_setImage(with: URL.init(string: img), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tblMenu.deselectRow(at: indexPath as IndexPath, animated: true)
        if let drawerController = parent as? KYDrawerController {
            drawerController.setDrawerState(.closed, animated: true)
        }
        if indexPath.section == 0{
            let VC = storybord.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
            present(VC, animated: true, completion: nil)
        }
        else{
            if selectedCategory == "CourtAndClub"{
                CourtSelectebleView(indexPath)
            }
            else if selectedCategory == "Social"{
                SocialSelectebleView(indexPath)
            }
            else if selectedCategory == "Market"{
                MarketSelectebleView(indexPath)
            }
            else if selectedCategory == "Courses"{
                CourcesSelectebleView(indexPath)
            }
            else if selectedCategory == "Offers"{
                OfferSelectebleView(indexPath)
            }
            else{
                
            }
        }
    }
    
    
}
//MARK: Open Category wise View
extension MenuVC{
    fileprivate func CourtSelectebleView(_ indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            ChangeCategoryClass.shared.OpenCourtVC()
            break
        case 1:
            let VC = storybord.instantiateViewController(withIdentifier: "FavouriteListVC") as! FavouriteListVC
            present(VC, animated: true, completion: nil)
            break
        case 2:
            ChangeCategoryClass.shared.OpenCourtVC(selectedIndex: 1)
            break
        case 3:
            ChangeCategoryClass.shared.OpenCourtVC(selectedIndex: 2)
            break
        case 4:
            let VC = Categorystorybord.instantiateViewController(withIdentifier: "navcategory")
            show(VC, sender: self)
            break
        case 5:
            let VC = storybord.instantiateViewController(withIdentifier: "BookMarkListVC") as! BookMarkListVC
            present(VC, animated: true, completion: nil)
            break
        case 6:
            let VC = storybord.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            present(VC, animated: true, completion: nil)
            break
        case 7:
            UserDefaults.standard.set(false, forKey: "IsLogin")
            let nav = Loginstorybord.instantiateViewController(withIdentifier: "navSignIn")
            AppDelegate.sharedDelegate().window?.rootViewController = nav
            AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
            break
        default:
            break
        }
    }
    
    fileprivate func CourcesSelectebleView(_ indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            ChangeCategoryClass.shared.OpenTrainingVC()
            break
        case 1:
            let VC = storybord.instantiateViewController(withIdentifier: "FavouriteListVC") as! FavouriteListVC
            present(VC, animated: true, completion: nil)
            break
        case 2:
            ChangeCategoryClass.shared.OpenTrainingVC(selectedIndex: 1)
            break
        case 3:
            ChangeCategoryClass.shared.OpenTrainingVC(selectedIndex: 2)
            break
        case 4:
            let VC = Categorystorybord.instantiateViewController(withIdentifier: "navcategory")
            show(VC, sender: self)
            break
        case 5:
            let VC = storybord.instantiateViewController(withIdentifier: "BookMarkListVC") as! BookMarkListVC
            present(VC, animated: true, completion: nil)
            break
        case 6:
            let VC = storybord.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            present(VC, animated: true, completion: nil)
            break
        case 7:
            UserDefaults.standard.set(false, forKey: "IsLogin")
            let nav = Loginstorybord.instantiateViewController(withIdentifier: "navSignIn")
            AppDelegate.sharedDelegate().window?.rootViewController = nav
            AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
            break
        default:
            break
        }
    }
    
    fileprivate func SocialSelectebleView(_ indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            ChangeCategoryClass.shared.OpenSocialVC()
            break
        case 1:
            let VC = storybord.instantiateViewController(withIdentifier: "FavouriteListVC") as! FavouriteListVC
            present(VC, animated: true, completion: nil)
            break
        case 2:
            ChangeCategoryClass.shared.OpenSocialVC(selectedIndex: 2)
            break
        case 3:
            ChangeCategoryClass.shared.OpenSocialVC(selectedIndex: 3)
            break
        case 4:
            let VC = Categorystorybord.instantiateViewController(withIdentifier: "navcategory")
            show(VC, sender: self)
            break
        case 5:
            let VC = storybord.instantiateViewController(withIdentifier: "BookMarkListVC") as! BookMarkListVC
            present(VC, animated: true, completion: nil)
            break
        case 6:
            let VC = storybord.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            present(VC, animated: true, completion: nil)
            break
        case 7:
            UserDefaults.standard.set(false, forKey: "IsLogin")
            let nav = Loginstorybord.instantiateViewController(withIdentifier: "navSignIn")
            AppDelegate.sharedDelegate().window?.rootViewController = nav
            AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
            break
        default:
            break
        }
    }
    
    fileprivate func MarketSelectebleView(_ indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            ChangeCategoryClass.shared.OpenMarketVC()
            break
        case 1:
            let VC = storybord.instantiateViewController(withIdentifier: "FavouriteListVC") as! FavouriteListVC
            present(VC, animated: true, completion: nil)
            break
        case 2:
            ChangeCategoryClass.shared.OpenMarketVC(selectedIndex: 1)
            break
        case 3:
            ChangeCategoryClass.shared.OpenMarketVC(selectedIndex: 2)
            break
        case 4:
            let VC = Categorystorybord.instantiateViewController(withIdentifier: "navcategory")
            show(VC, sender: self)
            break
        case 5:
            let VC = storybord.instantiateViewController(withIdentifier: "BookMarkListVC") as! BookMarkListVC
            present(VC, animated: true, completion: nil)
            break
        case 6:
            let VC = storybord.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            present(VC, animated: true, completion: nil)
            break
        case 7:
            UserDefaults.standard.set(false, forKey: "IsLogin")
            let nav = Loginstorybord.instantiateViewController(withIdentifier: "navSignIn")
            AppDelegate.sharedDelegate().window?.rootViewController = nav
            AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
            break
        default:
            break
        }
    }
    
    fileprivate func OfferSelectebleView(_ indexPath: IndexPath) {
        switch(indexPath.row){
        case 0:
            ChangeCategoryClass.shared.OpenOffersVC()
            break
        case 1:
            let VC = storybord.instantiateViewController(withIdentifier: "FavouriteListVC") as! FavouriteListVC
            present(VC, animated: true, completion: nil)
            break
        case 2:
            ChangeCategoryClass.shared.OpenOffersVC(selectedIndex: 1)
            break
        case 3:
            ChangeCategoryClass.shared.OpenOffersVC(selectedIndex: 2)
            break
        case 4:
            let VC = Categorystorybord.instantiateViewController(withIdentifier: "navcategory")
            show(VC, sender: self)
            break
        case 5:
            let VC = storybord.instantiateViewController(withIdentifier: "BookMarkListVC") as! BookMarkListVC
            present(VC, animated: true, completion: nil)
            break
        case 6:
            let VC = storybord.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
            present(VC, animated: true, completion: nil)
            break
        case 7:
            UserDefaults.standard.set(false, forKey: "IsLogin")
            let nav = Loginstorybord.instantiateViewController(withIdentifier: "navSignIn")
            AppDelegate.sharedDelegate().window?.rootViewController = nav
            AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
            break
        default:
            break
        }
    }
}
