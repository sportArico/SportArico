

import UIKit
import XLPagerTabStrip

class SocialGroupChatVC: UIViewController,IndicatorInfoProvider {

    var itemInfo: IndicatorInfo = IndicatorInfo(title: "Group Chat")
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    //MARK: Outlet
    @IBOutlet weak var tblChatView: UITableView!
    @IBOutlet weak var txtmessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    //=== End ===//
    
    //MARK: Variable
    var ArraySocialGroupChat:[SocialGroupChatData] = []
    var group_id = ""
    var DetailData:SocialGroupDetailData?
    //=== End ===//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        self.APICallSocialGroupChatListGet(user_id: (UserManager.shared.currentUser?.user_id)!, group_id: self.group_id)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSend(_ sender: Any) {
        if !(txtmessage.text?.isEmpty)!{
            self.InsertGroupChatText(user_id: (UserManager.shared.currentUser?.user_id)!, group_id: self.group_id, Text: SprotsArico.encode(txtmessage.text!))
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "Enter some value to send message", controller: self)
        }
    }
    
    //MARK: - Customization
    func customization() {
        self.tblChatView.estimatedRowHeight = 60
        self.tblChatView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.contentInset.bottom = 50
        //self.tableView.scrollIndicatorInsets.bottom = 50
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

extension SocialGroupChatVC:UITableViewDataSource,UITableViewDelegate{
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArraySocialGroupChat.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = self.ArraySocialGroupChat[indexPath.row]
        if obj.userId != UserManager.shared.currentUser?.user_id{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Sender", for: indexPath) as! SenderCell
            cell.clearCellData()
            cell.message.text = decode(obj.chatText!)
            cell.profilePic.sd_setImage(with: URL.init(string: (obj.userInfo?.profileImage)!),placeholderImage: #imageLiteral(resourceName: "square_blank_img"),completed: nil)
            cell.lblTimeAgo.text = obj.chatTime
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Receiver", for: indexPath) as! ReceiverCell
            cell.clearCellData()
            cell.message.text = decode(obj.chatText!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension SocialGroupChatVC{
    func APICallSocialGroupChatListGet(user_id: String,group_id: String) {
        SocialManager.shared.GetGroupChatList(User_Id: user_id, Group_id: group_id) { (ArrayGroupChatData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayGroupChatData.count > 0{
                self.ArraySocialGroupChat = ArrayGroupChatData as! [SocialGroupChatData]
                self.tblChatView.delegate = self
                self.tblChatView.dataSource = self
                self.tblChatView.reloadData()
                if self.ArraySocialGroupChat.count > 0{
                     self.tblChatView.scrollToBottom()
                }
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no group chat available", controller: self)
            }
        }
    }
    func InsertGroupChatText(user_id: String,group_id: String,Text: String) {
        SocialManager.shared.InsertGroupChat(User_id: user_id, Group_id: group_id, Chat_Text: Text) { (isInsert, error) in
            if isInsert == true{
                self.txtmessage.resignFirstResponder()
                self.txtmessage.text = ""
                self.APICallSocialGroupChatListGet(user_id: (UserManager.shared.currentUser?.user_id)!, group_id: self.group_id)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
    
}
