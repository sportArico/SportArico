

import UIKit

class ChangePasswordVC: UIViewController {

    
    //MARK: Outlet
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        guard (txtOldPassword.text  == "" ? nil : txtOldPassword.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Old Password", controller: self)
            return
        }
        guard (txtNewPassword.text  == "" ? nil : txtNewPassword.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid New Password", controller: self)
            return
        }
        self.APICallChangePass(user_id: (UserManager.shared.currentUser?.user_id)!, Old_Pass: txtOldPassword.text!, New_Pass: txtNewPassword.text!)
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
extension ChangePasswordVC{
    func APICallChangePass(user_id: String,Old_Pass: String,New_Pass: String) {
        SettingManager.shared.ChangePassword(withID: user_id, Old_Pass: Old_Pass, New_Pass: New_Pass) { (isChange, error) in
            if isChange == true{
                let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}
