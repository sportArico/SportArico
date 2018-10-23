
import UIKit
import XLPagerTabStrip

class SocialUserListChatVC: UIViewController,IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = IndicatorInfo(title: "User List")
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    //MARK: Outlet
    @IBOutlet weak var tblUserList: UITableView!
    //=== End ===//
    
    //MARK: Variable
    var ArrayDetailGroupUserList:SocialUserListData?
    var group_id = ""
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.APICallGetGroupUserList(group_id: self.group_id, user_Id: (UserManager.shared.currentUser?.user_id)!)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that cvarbe recreated.
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

extension SocialUserListChatVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.ArrayDetailGroupUserList?.members?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserGroupListCell", for: indexPath) as? UserGroupListCell else {
            return UITableViewCell()
        }
        cell.lblName.text = self.ArrayDetailGroupUserList?.members![indexPath.row].fullName
        cell.lblMSG.text = self.ArrayDetailGroupUserList?.members![indexPath.row].dataObj?.chatText
        cell.imgUserImage.sd_setImage(with: URL.init(string: (self.ArrayDetailGroupUserList?.members![indexPath.row].profileImage)!), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
        cell.lblTimeAgo.text = self.ArrayDetailGroupUserList?.members![indexPath.row].dataObj?.chatTime
        cell.TimeWidth.constant = cell.lblTimeAgo.intrinsicContentSize.width
        cell.lblCount.layer.cornerRadius = cell.lblCount.frame.height / 2
        cell.lblCount.clipsToBounds = true
        cell.lblCount.text = self.ArrayDetailGroupUserList?.members![indexPath.row].dataObj?.chatCount
        cell.lblCount.backgroundColor = UIColor.orange
        if Int((self.ArrayDetailGroupUserList?.members![indexPath.row].dataObj?.chatCount ?? "0")!) == 0{
            cell.lblCount.isHidden = true
        }
        else{
            cell.lblCount.isHidden = false
        }
        if self.ArrayDetailGroupUserList?.members![indexPath.row].isOnline == 0{
            cell.lblIsOnline.backgroundColor = UIColor.green
        }
        else{
            cell.lblIsOnline.backgroundColor = UIColor.red
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ArrayDetailGroupUserList?.members![indexPath.row].dataObj?.chatCount = "0"
        self.tblUserList.reloadRows(at: [indexPath], with: .none)
        let storybord = UIStoryboard(name: "Social", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SocialSingleChatVC") as! SocialSingleChatVC
        VC.group_id = (self.ArrayDetailGroupUserList?.groupDetails?.first?.groupId)!
        VC.Receiver_id = (self.ArrayDetailGroupUserList?.members![indexPath.row].userId)!
        navigationController?.pushViewController(VC, animated: true)
    }
}
extension SocialUserListChatVC{
    func APICallGetGroupUserList(group_id: String, user_Id: String) {
        SocialManager.shared.GetGroupMemberList(User_Id: user_Id, Group_id: group_id) { (groupUserListData, error) in
            if error != ""{
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else if groupUserListData != nil{
                self.ArrayDetailGroupUserList = groupUserListData
                self.tblUserList.delegate = self
                self.tblUserList.dataSource = self
                self.tblUserList.reloadData()
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "no data available", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
