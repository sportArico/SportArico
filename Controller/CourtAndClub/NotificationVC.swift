

import UIKit
import KYDrawerController

class NotificationVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tblNotification: UITableView!
    //=== End ===//
    
    //MARK: Variable
    var ArrayNotificationList:[NotificationData] = []
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblNotification.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.GetNotificationList(User_Id: (UserManager.shared.currentUser?.user_id)!)
        
        // Do any additional setup after loading the view.
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
    
    @IBAction func btnUser(_ sender: Any) {
        
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
extension NotificationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrayNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.imgUserImage.sd_setImage(with: URL.init(string: self.ArrayNotificationList[indexPath.row].profileImage!), placeholderImage: #imageLiteral(resourceName: "square_blank_img") ,completed: nil)
        cell.lblName.text = self.ArrayNotificationList[indexPath.row].fullName
        cell.lblDes.text = self.ArrayNotificationList[indexPath.row].notificationDescription
        cell.lblTime.text = self.ArrayNotificationList[indexPath.row].timeAgo
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storybord = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storybord.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
//        navigationController?.pushViewController(VC, animated: true)
    }
    
}
extension NotificationVC{
    func GetNotificationList(User_Id: String) {
        NotificationManager.shared.GetNotificationList(UserId: User_Id) { (NotificationListData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if NotificationListData.count > 0{
                self.ArrayNotificationList = NotificationListData as! [NotificationData]
                self.tblNotification.delegate = self
                self.tblNotification.dataSource = self
                self.tblNotification.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no notification available", controller: self)
            }
        }
    }
}
