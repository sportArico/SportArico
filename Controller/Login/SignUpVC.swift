

import UIKit
import CountryPickerView

class SignUpVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnCountryWidth: NSLayoutConstraint!
    @IBOutlet weak var imgcountryImage: UIImageView!
    @IBOutlet weak var txtAboutMe: UITextField!
    
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    
    //=== End ===//
    
    //MARK: Variable
    let countryPickerView = CountryPickerView()
    var gender = "male"
    var handicap = "yes"
    var user_type = "5"
    //=== End ==//
    
    fileprivate func SetUpUI() {
        btnMale.layer.cornerRadius = btnMale.layer.frame.width / 2
        btnMale.clipsToBounds = true
        btnFemale.layer.cornerRadius = btnFemale.layer.frame.width / 2
        btnFemale.clipsToBounds = true
        btnNo.layer.cornerRadius = btnNo.layer.frame.width / 2
        btnNo.clipsToBounds = true
        btnYes.layer.cornerRadius = btnYes.layer.frame.width / 2
        btnYes.clipsToBounds = true
        countryPickerView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        let t = countryPickerView.getCountryByCode(Locale.current.regionCode ?? "US")
        btnCountry.setTitle("\(t?.phoneCode ?? "+1")", for: .normal)
        imgcountryImage.image = t?.flag
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnFemale(_ sender: Any) {
        gender = "female"
        btnFemale.backgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
        btnMale.backgroundColor = UIColor.colorFromHex(hexString: "#EBEBF1")
    }
    @IBAction func btnMale(_ sender: Any) {
        gender = "male"
        btnFemale.backgroundColor = UIColor.colorFromHex(hexString: "#EBEBF1")
        btnMale.backgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
    }
    @IBAction func btnNo(_ sender: Any) {
        handicap = "no"
        btnNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
        btnYes.setImage(UIImage(named:""), for: .normal)
    }
    @IBAction func btnYes(_ sender: Any) {
        handicap = "yes"
        btnNo.setImage(UIImage(named:""), for: .normal)
        btnYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
    }
    @IBAction func btnCountryCode(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
       // dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSelectOTPToSend(_ sender: UIButton) {
        
        btnEmail.isSelected = false
        btnMobile.isSelected = false
        sender.isSelected = true
    }
    
    
    
    @IBAction func btnSignUp(_ sender: Any) {
        guard (txtName.text  == "" ? nil : txtName.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Name", controller: self)
            return
        }
        guard (txtEmail.text  == "" ? nil : txtEmail.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Email-ID", controller: self)
            return
        }
        guard (validateEmail(email: txtEmail.text!) != nil ? txtEmail.text : nil) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Email-ID", controller: self)
            return
        }
        guard (txtPassword.text  == "" ? nil : txtPassword.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Password", controller: self)
            return
        }
        guard (txtMobileNo.text  == "" ? nil : txtMobileNo.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Mobile Number", controller: self)
            return
        }
        guard (txtAboutMe.text  == "" ? nil : txtAboutMe.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter About me", controller: self)
            return
        }
        
        var otpTo = ""
        if btnMobile.isSelected
        {
            otpTo = "phone"
        }
        else
        {
            otpTo = "email"
        }
        
        let param:[String:String] = ["full_name":txtName.text!,"email":txtEmail.text!,"password":txtPassword.text!,"country_code":btnCountry.currentTitle!,"phone":txtMobileNo.text!,"about":txtAboutMe.text!,"gender":self.gender,"user_type":self.user_type,"otp_to" : otpTo]
        
        print(param)
        
        self.APICallRegister(param: param)
        //,"handicapped":""
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
extension SignUpVC:CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.imgcountryImage.image = country.flag
        btnCountry.setTitle(country.phoneCode, for: .normal)
        let textWidth = (btnCountry.currentTitle! as NSString).size(withAttributes:[NSAttributedStringKey.font:btnCountry.titleLabel!.font!]).width
        btnCountryWidth.constant = textWidth + 20
        btnCountry.layoutIfNeeded()
    }
}

extension SignUpVC{
    func APICallRegister(param:[String:String]) {
        UserManager.shared.signUp(withParametrs: param, avatar: nil) { (isRegister, userData, error) in
            if isRegister == true{
                let alert = UIAlertController(title: "Success", message: "\(error ?? "")", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    let storybord = UIStoryboard(name: "Login", bundle: nil)
                    let VC = storybord.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
                    VC.userData = userData
                    VC.otpSendTo = self.btnMobile.isSelected ? "phone":"email"
                    VC.otpSendText = self.btnMobile.isSelected ? self.btnCountry.currentTitle! + " " + self.txtMobileNo.text!:self.txtEmail.text!
                    self.navigationController?.pushViewController(VC, animated: true)
                    
                    //self.present(VC, animated: true, completion: nil)
                    
                    UserDefaults.standard.set(self.txtEmail.text!, forKey: "emailsave")
                    UserDefaults.standard.set(self.txtPassword.text!, forKey: "passwordsave")
                    UserDefaults.standard.synchronize()
                    
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}
