

import UIKit


class SocialSingleChatVC: UIViewController{

   
    //MARK: Outlet
    @IBOutlet weak var tblChatView: UITableView!
    @IBOutlet weak var txtmessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    //=== End ===//
    
    //MARK: Variable
    var group_id = ""
    var Receiver_id = ""
    var ChatDetailData:SocialSingleChatListData?
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        self.APICallSocialGroupChatListGet(user_id: (UserManager.shared.currentUser?.user_id)!, group_id: self.group_id, receiver_id: self.Receiver_id)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didReceiveData, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self, name: .didReceiveData, object: nil)
    }
    @objc func onDidReceiveData(_ notification: Notification)
    {
        if let data = notification.userInfo as? [AnyHashable: Any]
        {
            guard let data = try? JSONSerialization.data(withJSONObject: data, options: .prettyPrinted),
                  let prettyPrinted = String(data: data, encoding: .utf8) else {
                return
            }
        }
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSend(_ sender: Any) {
        if !(txtmessage.text?.isEmpty)!{
            self.InsertSingleChatMSGText(user_id: (UserManager.shared.currentUser?.user_id)!, group_id: self.group_id, Text: SprotsArico.encode(txtmessage.text!), Receiver_id: self.Receiver_id)
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "Enter some value to send message", controller: self)
        }
    }
    
    //MARK: - Customization
    func customization() {
        self.tblChatView.estimatedRowHeight = 50
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
extension SocialSingleChatVC:UITableViewDataSource,UITableViewDelegate{
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.ChatDetailData?.chatData?.count)!
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
        let obj = self.ChatDetailData?.chatData![indexPath.row]
        if obj?.userId != UserManager.shared.currentUser?.user_id{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Sender", for: indexPath) as! SenderCell
            cell.clearCellData()
            cell.message.text = decode((obj?.chatText)!)
            cell.profilePic.sd_setImage(with: URL.init(string: (obj?.receiverData?.profileImage)!), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
            cell.lblTimeAgo.text = obj?.chatTime
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Receiver", for: indexPath) as! ReceiverCell
            cell.clearCellData()
            cell.message.text = decode((obj?.chatText)!)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
extension SocialSingleChatVC{
    func APICallSocialGroupChatListGet(user_id: String,group_id: String,receiver_id: String) {
        SocialManager.shared.GetSingleChatList(User_Id: user_id, Group_id: group_id, Receiver_id: receiver_id) { (ChatHistoryData, error) in
            if error != ""{
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else if ChatHistoryData != nil{
                self.ChatDetailData = ChatHistoryData
                self.lblName.text = "Venue: \(ChatHistoryData?.groupDetails?.first?.groupTitle ?? "")"
                //lblLocation.text = data?.location
                self.lblDate.text = GetFormatedDate(From: "yyyy-MM-dd", To: "EEE,dd MMM", Value: (ChatHistoryData?.groupDetails?.first?.eventDate ?? "")!)
                self.lblTime.text = ChatHistoryData?.groupDetails?.first?.eventTime ?? ""
                self.tblChatView.delegate = self
                self.tblChatView.dataSource = self
                self.tblChatView.reloadData()
                if self.ChatDetailData!.chatData!.count > 0{
                    self.tblChatView.scrollToBottom()
                }
                SocialManager.shared.ChatReadStatusChange(With: "\(self.group_id)/\(self.Receiver_id)/2", completion: { (isRead, error) in
                    
                })
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
    func InsertSingleChatMSGText(user_id: String,group_id: String,Text: String,Receiver_id: String) {
        SocialManager.shared.InsertSingleChatMSG(User_id: user_id, Group_id: group_id, Chat_Text: Text, Receiver_id: Receiver_id) { (SendDataMSG, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if SendDataMSG.count > 0{
                self.ChatDetailData?.chatData = SendDataMSG as? [SocialSingleChatData]
                self.txtmessage.resignFirstResponder()
                self.txtmessage.text = ""
                self.tblChatView.delegate = self
                self.tblChatView.dataSource = self
                self.tblChatView.reloadData()
                if self.ChatDetailData!.chatData!.count > 0 {
                    self.tblChatView.scrollToBottom()
                }
            }
            else{
                Utility.setAlertWith(title: "Error", message: "Message not send please try again!", controller: self)
            }
        }
    }
}
