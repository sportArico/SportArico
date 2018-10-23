
import UIKit
import KYDrawerController

class SocialVC: UIViewController {
    
    
    //MARK: Outlet
    @IBOutlet weak var tblSocial: UITableView!
    @IBOutlet weak var lblLocationName: UILabel!
    //=== End ==//
    
    //MARK: Variable
    var section = ["My Group","Groups"]
    var SocialGroupList:SocialGroupData?
    //=== End ==//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let param = ["sport_id":"","latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"location":AppDelegate.sharedDelegate().location_name,"gender":"","distance":"","user_id":UserManager.shared.currentUser?.user_id]
        self.APICallGetSocialGroup(Param: param as! [String : String])
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblLocationName.text = AppDelegate.sharedDelegate().location_name
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    @IBAction func btnCreateNewGroup(_ sender: Any) {
        let storybord = UIStoryboard(name: "Social", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "NewTeamVC") as! NewTeamVC
        VC.OnReload = { (isReload) in
            if isReload == true{
                let param:[String:String] = ["user_id":(UserManager.shared.currentUser?.user_id)!]
                self.APICallGetSocialGroup(Param: param)
            }
        }
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func btnFilter(_ sender: Any) {
        
    }
    @IBAction func btnFire(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "ChangeCategoryVC") as! ChangeCategoryVC
        ivc.modalPresentationStyle = .overCurrentContext
        ivc.modalTransitionStyle = .coverVertical
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func btnChangeLocation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "SearchLocationVC") as! SearchLocationVC
        ivc.OnSave = { (Param) in
            print(Param)
            let param = ["sport_id":"","latitude":Param["latitude"]!,"longitude":Param["longitude"]!,"location":AppDelegate.sharedDelegate().location_name,"gender":"","distance":"","user_id":UserManager.shared.currentUser?.user_id]
            self.APICallGetSocialGroup(Param: param as! [String : String])
        }
        navigationController?.pushViewController(ivc, animated: true)
    }
    @IBAction func btnNotification(_ sender: Any) {
        tabBarController?.selectedIndex = 3
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FillterSocial"{
            let popview = segue.destination as! ModifyBookingVC
            popview.OnSave = { (Param) in
                print(Param)
                self.APICallGetSocialGroup(Param: Param)
            }
        }
    }
    
}
extension SocialVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if self.SocialGroupList?.myGroup?.count == 0 {
                self.tblSocial.setEmptyMessage("No groups found for selected criteria")
            } else {
                self.tblSocial.restore()
            }
            return self.SocialGroupList?.myGroup?.count ?? 0
        }
        else{
            if self.SocialGroupList?.otherGroup?.count == 0 {
                self.tblSocial.setEmptyMessage("No groups found for selected criteria")
            } else {
                self.tblSocial.restore()
            }
            return self.SocialGroupList?.otherGroup?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SocialHomeCell", for: indexPath) as? SocialHomeCell else{return UITableViewCell()}
        if indexPath.section == 0{
            cell.imgUserImage.sd_setImage(with: URL.init(string: self.SocialGroupList?.myGroup![indexPath.row].userInfo?.profileImage ?? ""), placeholderImage: #imageLiteral(resourceName: "square_blank_img") ,completed: nil)
            cell.lblName.text = self.SocialGroupList?.myGroup![indexPath.row].groupTitle
            cell.lblLocation.text = self.SocialGroupList?.myGroup![indexPath.row].location
            cell.lblGreeting.text = self.SocialGroupList?.myGroup![indexPath.row].eventTime
            cell.lblDate.text = "\(GetFormatedDate(From: "yyyy-MM-dd", To: "EEE,dd MMM", Value: (self.SocialGroupList?.myGroup![indexPath.row].eventDate)!) ?? "")"
            cell.lblCount.text = "\(self.SocialGroupList?.myGroup![indexPath.row].memberCount ?? 0)/\(self.SocialGroupList?.myGroup![indexPath.row].maxSize ?? "")"
            cell.CountWidth.constant = cell.lblCount.intrinsicContentSize.width
        }
        else{
            cell.imgUserImage.sd_setImage(with: URL.init(string: self.SocialGroupList?.otherGroup![indexPath.row].userInfo?.profileImage ?? ""), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
            cell.lblName.text = self.SocialGroupList?.otherGroup![indexPath.row].groupTitle
            cell.lblLocation.text = self.SocialGroupList?.otherGroup![indexPath.row].location
            cell.lblGreeting.text = self.SocialGroupList?.otherGroup![indexPath.row].eventTime
            cell.lblDate.text = "\(GetFormatedDate(From: "yyyy-MM-dd", To: "EEE,dd MMM", Value: (self.SocialGroupList?.otherGroup![indexPath.row].eventDate)!) ?? "")"
            cell.lblCount.text = "\(self.SocialGroupList?.otherGroup![indexPath.row].memberCount ?? 0)/\(self.SocialGroupList?.otherGroup![indexPath.row].maxSize ?? "")"
            cell.CountWidth.constant = cell.lblCount.intrinsicContentSize.width
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        //header.textLabel?.font = UIFont(name: "Futura", size: 38)!
        header.textLabel?.textColor = UIColor(red: 169, green: 169, blue: 169)
        header.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        header.layer.insertSublayer(gradient, at: 0)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storybord = UIStoryboard(name: "Social", bundle: nil)
        if indexPath.section == 0{
            let VC = storybord.instantiateViewController(withIdentifier: "SocialMyGroupDetailVC") as! SocialMyGroupDetailVC
            VC.Group_Id = (self.SocialGroupList?.myGroup![indexPath.row].groupId)!
            navigationController?.pushViewController(VC, animated: true)
        }
        else{
            let VC = storybord.instantiateViewController(withIdentifier: "SocialDetailVC") as! SocialDetailVC
            VC.Group_Id = (self.SocialGroupList?.otherGroup![indexPath.row].groupId)!
            navigationController?.pushViewController(VC, animated: true)
        }
        
    }
}
//MARK: API Call...
extension SocialVC{
    func APICallGetSocialGroup(Param: [String:String]) {
        SocialManager.shared.GetSocialGroupList(Param: Param) { (SocialGroupData, error) in
            self.tblSocial.delegate = self
            self.tblSocial.dataSource = self
            if SocialGroupData != nil{
                self.SocialGroupList = SocialGroupData
                self.tblSocial.reloadData()
            }
            else{
                if error != ""{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                    self.tblSocial.reloadData()
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
                    self.tblSocial.reloadData()
                }
            }
        }
    }
}
