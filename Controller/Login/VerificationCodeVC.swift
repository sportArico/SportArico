

import UIKit

class VerificationCodeVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnContactSupport: UIButton!
    @IBOutlet weak var btnT_C: UIButton!
    @IBOutlet weak var lblTopText: UILabel!
    @IBOutlet weak var btnResendOTP: UIButton!
    @IBOutlet weak var lblTime: UILabel!
    //=== End === //
    
    var isProvider = false
    var otpSendTo = ""
    var otpSendText = ""
    //MARK: Variable
    var userData: NSDictionary?
    var seconds = 60
    var timer = Timer()
    //=== End ==//
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        lblTopText.text = ""
        // Do any additional setup after loading the view.
         btnResendOTP.isHidden = true
        
//        if otpSendTo == "phone"
//        {
//            self.lblTopText.text = "Enter verification code we have sent to" + " \(userData?.value(forKey: "country_code") as? String ?? "") \(userData?.value(forKey: "phone") as? String ?? "")"
//        }
//        if otpSendTo == "email"
//        {
//            self.lblTopText.text = "Enter verification code we have sent to" + " \(userData?.value(forKey: "email") as? String ?? "")"
//        }
        
        self.lblTopText.text = "Enter verification code we have sent to \(otpSendText)" 
        
        runTimer()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnContinue(_ sender: Any) {
        guard (txtCode.text  == "" ? nil : txtCode.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid OTP", controller: self)
            return
        }
        
        let params:[String:String] = ["user_id": userData?.value(forKey: "user_id") as! String, "otp": txtCode.text!,"otp_to":otpSendTo]
        print(params)
        
        UserManager.shared.VeryfyOTP(param:params) { (isvalid, error) in
            if isvalid == true{
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    
                    if self.isProvider
                    {
                        let storybord = UIStoryboard(name: "Login", bundle: nil)
                        let VC = storybord.instantiateViewController(withIdentifier: "ProviderCategorySelectVC") as! ProviderCategorySelectVC
                        VC.userData = self.userData
                        
                        UserManager.shared.saveUserdata()
                        
                        self.navigationController?.pushViewController(VC, animated: true)
                    }
                    else
                    {
                        
                        UserManager.shared.login(withEmail: "\(UserDefaults.standard.value(forKey: "emailsave")!)", password: "\(UserDefaults.standard.value(forKey: "passwordsave")!)", FCM_Token: "", email_phone : "email" ,isremember: true) { (User, error) in
                            if error != nil{
                                Utility.setAlertWith(title: "Error", message: error, controller: self)
                            }
                            else{
                                    let storybord = UIStoryboard(name: "Category", bundle: nil)
                                    let VC = storybord.instantiateInitialViewController()
                                    AppDelegate.sharedDelegate().window?.rootViewController = VC
                                    AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
                            }
                        }
                        
                        
                    }
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
        //dismiss(animated: true, completion: nil)
    }
    @IBAction func btnContactSupport(_ sender: Any) {
        
    }
    @IBAction func btnT_C(_ sender: Any) {
        
    }
    @IBAction func BtnBack(_ sender: Any){
        //navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
        
         //self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnReSendOTP(_ sender: Any) {
        
        
        
        if btnResendOTP.currentTitle == "Resend"{
            
            //let params:[String:String] = ["country_code":userData?.value(forKey: "country_code") as! String,"user_id": userData?.value(forKey: "user_id") as! String, "phone": userData?.value(forKey: "phone") as! String,"otp_to":otpSendTo]
            
            
            let params:[String:String] = ["user_id": userData?.value(forKey: "user_id") as! String,"otp_to":otpSendTo]
            
            
            UserManager.shared.ResendOTP(Param:params) { (isReSend, error) in
                if isReSend == true{
                    let alert = UIAlertController(title: "Alert", message: error, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.btnResendOTP.isHidden = true
                    self.lblTime.isHidden = false
                    self.runTimer()
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            }
        }
        else{
            
        }
    }
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(VerificationCodeVC.updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if seconds == 0{
            timer.invalidate()
            btnResendOTP.isHidden = false
            lblTime.isHidden = true
            
        }
        else{
            seconds -= 1
            lblTime.text = "No code? - Resent after 00:\(seconds)"
            lblTime.isHidden = false
        }
    }
    //=== End == //
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

