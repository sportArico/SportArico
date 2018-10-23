

import UIKit
import CountryPickerView
import KRProgressHUD
import FBSDKLoginKit
import GoogleSignIn
import KYDrawerController
class SignUpProviderVC: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate {
    
    //MARK: Outlet
    @IBOutlet weak var btnCountry: UIButton!
    @IBOutlet weak var btnCountryWidth: NSLayoutConstraint!
    @IBOutlet weak var imgcountryImage: UIImageView!
    @IBOutlet weak var btnCourt: UIButton!
    @IBOutlet weak var btnMarket: UIButton!
    @IBOutlet weak var btnTraining: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtAbout: UITextField!
    
    @IBOutlet weak var btnMobile: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    
    //=== End ===//
    
    //MARK: Variable
    let countryPickerView = CountryPickerView()
    var Category_ID = "1"
    //=== End ==//
    
    fileprivate func SetUpUI() {
        countryPickerView.delegate = self
        btnCourt.imageView?.contentMode = .scaleAspectFit
        btnMarket.imageView?.contentMode = .scaleAspectFit
        btnTraining.imageView?.contentMode = .scaleAspectFit
        btnMarket.backgroundColor = UIColor.lightGray
        btnTraining.backgroundColor = UIColor.lightGray
        btnCourt.cornerRadius = btnCourt.layer.frame.height / 2
        btnCourt.clipsToBounds = true
        btnMarket.cornerRadius = btnMarket.layer.frame.height / 2
        btnMarket.clipsToBounds = true
        btnTraining.cornerRadius = btnTraining.layer.frame.height / 2
        btnTraining.clipsToBounds = true
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

    @IBAction func btnCountryCode(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
       // dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCourt(_ sender: Any) {
        
        if !btnCourt.isSelected
        {
            btnCourt.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
            btnCourt.isSelected = true
        }
        else
        {
            btnCourt.backgroundColor = UIColor.lightGray
            btnCourt.isSelected = false
        }
        
//        btnMarket.backgroundColor = UIColor.lightGray
//        btnTraining.backgroundColor = UIColor.lightGray
        self.Category_ID = "1"
    }
    @IBAction func btnMarket(_ sender: Any) {
        
        if !btnMarket.isSelected
        {
            btnMarket.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
            btnMarket.isSelected = true
        }
        else
        {
            btnMarket.backgroundColor = UIColor.lightGray
            btnMarket.isSelected = false
        }
        
        
//        btnMarket.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
//        btnCourt.backgroundColor = UIColor.lightGray
//        btnTraining.backgroundColor = UIColor.lightGray
        self.Category_ID = "3"
    }
    @IBAction func btnTraining(_ sender: Any) {
        
        if !btnTraining.isSelected
        {
            btnTraining.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
            btnTraining.isSelected = true
        }
        else
        {
            btnTraining.backgroundColor = UIColor.lightGray
            btnTraining.isSelected = false
        }
        
//        btnTraining.backgroundColor = UIColor(red: 47, green: 74, blue: 239)
//        btnCourt.backgroundColor = UIColor.lightGray
//        btnMarket.backgroundColor = UIColor.lightGray
        self.Category_ID = "2"
    }
    
    
    @IBAction func onSelectOTPToSend(_ sender: UIButton) {
        
        btnEmail.isSelected = false
        btnMobile.isSelected = false
        sender.isSelected = true
    }
    
    @IBAction func btnSignUpProvider(_ sender: Any) {
        
//        if !btnCourt.isSelected && !btnTraining.isSelected && !btnMarket.isSelected{
//            Utility.setAlertWith(title: "Alert", message: "Please select one category to continue with sportarico.", controller: self)
//            return
//        }
        
        guard (txtName.text  == "" ? nil : txtName.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid First Name", controller: self)
            return
        }
        
        guard (txtLastname.text  == "" ? nil : txtLastname.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Last Name", controller: self)
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
        guard (txtMobile.text  == "" ? nil : txtMobile.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Password", controller: self)
            return
        }
//        guard (txtAbout.text  == "" ? nil : txtAbout.text) != nil else {
//            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Password", controller: self)
//            return
//        }
//
//        if !btnCourt.isSelected && !btnTraining.isSelected && !btnMarket.isSelected
//        {
//            Utility.setAlertWith(title: "Alert", message: "Please Select Category.", controller: self)
//            return
//        }
//        self.Category_ID = ""
//        if btnCourt.isSelected
//        {
//            self.Category_ID = "1,"
//        }
//        if btnTraining.isSelected
//        {
//            self.Category_ID = self.Category_ID +  "2,"
//        }
//
//        if btnMarket.isSelected
//        {
//            self.Category_ID = self.Category_ID +  "3,"
//        }
//
//        self.Category_ID.removeLast()
//
        
//        let param:[String:String] = ["full_name":txtName.text!,"firstname":txtName.text!,"lastname":txtLastname.text!,"email":txtEmail.text!,"password":txtPassword.text!,"country_code":btnCountry.currentTitle!,"phone":txtMobile.text!,"about":txtAbout.text!,"category_id":self.Category_ID]
//
//
//        let storybord = UIStoryboard(name: "Login", bundle: nil)
//        let VC = storybord.instantiateViewController(withIdentifier: "ProviderCategorySelectVC") as! ProviderCategorySelectVC
//        VC.param = param
//
//        self.present(VC, animated: true, completion: nil)
        
        //self.navigationController?.pushViewController(VC, animated: true)
        
        
        var otpTo = ""
        if btnMobile.isSelected
        {
            otpTo = "phone"
        }
        else
        {
            otpTo = "email"
        }
        
        
        self.APICallRegister(param: ["last_name":txtLastname.text!,"first_name":txtName.text!,"email":txtEmail.text!,"password":txtPassword.text!,"country_code":btnCountry.currentTitle!,"phone":txtMobile.text!,"otp_to" : otpTo])
    }
    
    
    // MARK: - Facebook Login
    
    
    @IBAction func btnLoginFB(_ sender: Any) {
        KRProgressHUD.show()
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.loginBehavior = FBSDKLoginBehavior.browser
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_gender"], from: self) { (result, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                KRProgressHUD.dismiss()
                return
            }
            let fbloginresult : FBSDKLoginManagerLoginResult = result!
            if(fbloginresult.isCancelled) {
                KRProgressHUD.dismiss()
                return
            }
            guard let accessToken = FBSDKAccessToken.current() else {
                let alertController = UIAlertController(title: "Error", message: "Internet connection error.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            //let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, first_name, last_name, gender, picture.type(large)"])
            
            graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                KRProgressHUD.dismiss()
                if ((error) != nil)
                {
                    print("Error: \(error?.localizedDescription)")
                }
                else
                {
                    let data = result as! NSDictionary
                    //                    let firstName = data.value(forKey: "first_name") as! String
                    //                    let lastName = data.value(forKey: "last_name") as! String
                    //                    let fullName = firstName + " " + lastName
                    var strpic = ""
                    if let picturedata = data["picture"] as? [String : AnyObject]{
                        if let picdata = picturedata["data"] as? [String : AnyObject]{
                            strpic = picdata["url"] as? String ?? ""
                        }
                    }
                    print(data)
                     self.APICallFBLogin(param: ["fbid":"\(data.value(forKey: "id") as! String)","email":data.value(forKey: "email") as! String,"phone":"","full_name":data.value(forKey: "name") as! String,"gender":"","profile_img":"\(strpic)","login_from":"facebook","user_type":"provider","category_id":"1"])
                    
                    /*
                     login_from = facebook
                     login_from = twitter
                     login_from = google
                     */
                }
            })
            
           
        }
    }
    
    //MARK:- GoogleSignin
    
    @IBAction func btnLoginGP(_ sender: Any) {
        KRProgressHUD.show()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    //MARK:- GoogleSignin Delegate
    
    public func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        KRProgressHUD.dismiss()
    }
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
        if let error = error {
            KRProgressHUD.dismiss()
            print(error.localizedDescription)
            return
        }
        guard let authentication = user.authentication else { return }
        //let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        let fullName = user.profile.name as String
//        print(user.profile.name)
//        print(user.profile.email)
//        print(user.profile.imageURL(withDimension: 512))
//        print(user.userID)
        //MARK: Login Done.
        self.APICallFBLogin(param: ["fbid":user.userID,"email":user.profile.email,"phone":"","full_name":user.profile.name,"gender":"","profile_img":"\(user.profile.imageURL(withDimension: 512)!)","login_from":"google","user_type":"provider","category_id":"1"])
        
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
extension SignUpProviderVC:CountryPickerViewDelegate{
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.imgcountryImage.image = country.flag
        btnCountry.setTitle(country.phoneCode, for: .normal)
        let textWidth = (btnCountry.currentTitle! as NSString).size(withAttributes:[NSAttributedStringKey.font:btnCountry.titleLabel!.font!]).width
        btnCountryWidth.constant = textWidth + 20
        btnCountry.layoutIfNeeded()
    }
}

extension SignUpProviderVC{
    func navBack(action: UIAlertAction) {
        navigationController?.popToRootViewController(animated: true)
        
       // self.dismiss(animated: true, completion: nil)
    }
    
    func APICallRegister(param:[String:String]) {
        
        print(param)
        UserManager.shared.signUpProvider(withParametrs: param, avatar: nil) { (isRegister, userData,error) in
            
            print("++++++++++++++++")
            print(userData)
            
            if isRegister == true{
                let alert  = UIAlertController(title: "Success", message: "\(error ?? "")", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    let storybord = UIStoryboard(name: "Login", bundle: nil)
                    let VC = storybord.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
                    VC.userData = userData
                    VC.isProvider = true
                    VC.otpSendTo = self.btnMobile.isSelected ? "phone":"email"
                    VC.otpSendText = self.btnMobile.isSelected ? self.btnCountry.currentTitle! + " " + self.txtMobile.text!:self.txtEmail.text!
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
    
    
    func APICallFBLogin(param:[String:String]) {
        
        UserManager.shared.signUpProviderForSocial(withParametrs: param) { (isRegister, userData,error) in
                let alert  = UIAlertController(title: "Success", message: "\(error ?? "")", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
                let storybord = UIStoryboard(name: "Provider", bundle: nil)
                let storyBoardSlideMenu = UIStoryboard(name: "Menu", bundle: nil)
                guard let tabBarVC = storybord.instantiateViewController(withIdentifier: "ProviderHomeVC") as? ProviderHomeVC,
                    let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                        withIdentifier: "ProviderMenuVC") as? ProviderMenuVC else {
                            return
                }
                let mainViewController   = tabBarVC
                let drawerViewController = slideMenuViewController
                let drawerController     = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
                drawerController.mainViewController = UINavigationController.init(rootViewController: mainViewController)
                drawerController.drawerViewController = drawerViewController
                AppDelegate.sharedDelegate().window?.rootViewController = drawerController
                AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
                
                
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            KRProgressHUD.dismiss()

        }
    }
}

/*
 
 let storybord = UIStoryboard(name: "Category", bundle: nil)
 let VC = storybord.instantiateInitialViewController()
 AppDelegate.sharedDelegate().window?.rootViewController = VC
 AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
 */

