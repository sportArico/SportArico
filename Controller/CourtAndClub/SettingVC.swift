

import UIKit
import CountryPickerView

class SettingVC: UIViewController {
    
    
    //MARK: Outlet
    @IBOutlet weak var btnChangeNoti: UISwitch!
    @IBOutlet weak var lblLang: UILabel!
    @IBOutlet weak var lblLangWidth: NSLayoutConstraint!
    @IBOutlet weak var imgFlagImage: UIImageView!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var lblCountryName: UILabel!
    //=== End ===//
    

    //MARK: Variable
    let countryPickerView = CountryPickerView()
    var UserProfileData:UserProfileData?
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryPickerView.delegate = self
        
        let t = countryPickerView.getCountryByCode(Locale.current.regionCode ?? "US")
        lblCountryName.text = t?.name
        imgFlagImage.image = t?.flag
        
        UserManager.shared.GetUserProfile(withUserID: (UserManager.shared.currentUser?.user_id)!) { (UserData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else{
                self.UserProfileData = UserData
                if self.UserProfileData?.notificationStatus == "1"{
                    self.btnChangeNoti.isOn = true
                }
                else{
                    self.btnChangeNoti.isOn = false
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func btnSelectCountry(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func btnChangePassword(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        present(VC, animated: true, completion: nil)
    }
    @IBAction func btnChangeLan(_ sender: Any) {
        
    }
    @IBAction func btnHelpSupport(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "HelpAndSupportVC") as! HelpAndSupportVC
        present(VC, animated: true, completion: nil)
    }
    @IBAction func btnInviteFriend(_ sender: Any) {
        let message = "Try this app to "
        //if let link = NSURL(string: "https://itunes.apple.com/us/app/easyvent/id1401839200?ls=1&mt=8") {
        let objectsToShare = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        //navigationController?.present(activityVC, animated: true, completion: nil)
        // }
    }
    @IBAction func btnChangeNoti(_ sender: Any) {
        if btnChangeNoti.isOn{
            SettingManager.shared.ChangeNotificationStatus(withID: (UserManager.shared.currentUser?.user_id)!, Status: "1", completion: { (isChange, error) in
                if isChange == true{
                    let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            })
        }
        else{
            SettingManager.shared.ChangeNotificationStatus(withID: (UserManager.shared.currentUser?.user_id)!, Status: "0", completion: { (isChange, error) in
                if isChange == true{
                    let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            })
        }
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

extension SettingVC:CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.imgFlagImage.image = country.flag
        self.lblCountryName.text = country.name
    }
}
