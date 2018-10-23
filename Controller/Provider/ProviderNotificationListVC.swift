

import UIKit
import KYDrawerController

class ProviderNotificationListVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tblNotification: UITableView!
    //=== End ===//
    
    //MARK: Variable
    var ArrayNotificationList:[ProviderNotificationData] = []
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblNotification.rowHeight = UITableViewAutomaticDimension
        tblNotification.estimatedRowHeight = 55
        self.GetNotificationList(User_Id: (UserManager.shared.currentUser?.user_id)!)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
extension ProviderNotificationListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrayNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        cell.lblName.text = self.ArrayNotificationList[indexPath.row].notificationTitle
        cell.lblDes.text = self.ArrayNotificationList[indexPath.row].notificationDescription
        cell.lblTime.text = self.ArrayNotificationList[indexPath.row].timeAgo
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let storybord = UIStoryboard(name: "Main", bundle: nil)
        //        let VC = storybord.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        //        navigationController?.pushViewController(VC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
extension ProviderNotificationListVC{
    func GetNotificationList(User_Id: String) {
        NotificationManager.shared.GetProviderNotificationList(UserId: User_Id) { (NotificationListData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if NotificationListData.count > 0{
                self.ArrayNotificationList = NotificationListData as! [ProviderNotificationData]
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

