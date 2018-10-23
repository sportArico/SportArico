

import UIKit
import FBSDKLoginKit
import KRProgressHUD
import GoogleSignIn
import KYDrawerController

class SignInVC: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    //MARK: Outlet For SignIn
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    //=== END ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(swipeDown)
        txtEmail.text = "test102@gmail.com"
        txtPassword.text = "abcd1234"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        let storybord = UIStoryboard(name: "Login", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SelectSignUpVC") as! SelectSignUpVC
        navigationController?.pushViewController(VC, animated: true)
       //present(VC, animated: true, completion: nil)
    }
    @IBAction func btnForgotPassword(_ sender: Any) {
        let storybord = UIStoryboard(name: "Login", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SelectCountryVC") as! SelectCountryVC
        navigationController?.pushViewController(VC, animated: true)
        //present(VC, animated: true, completion: nil)
    }
    @IBAction func btnSignIn(_ sender: Any) {
        guard (txtEmail.text  == "" ? nil : txtEmail.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Email-ID or Mobile Number.", controller: self)
            return
        }
        
        guard (txtPassword.text  == "" ? nil : txtPassword.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Password", controller: self)
            return
        }
        self.LoginAPICall()
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                dismiss(animated: true, completion: nil)
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
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
        print(user.profile.name)
        print(user.profile.email)
        print(user.profile.imageURL(withDimension: 512))
        print(user.userID)
        //MARK: Login Done.
        self.APICallFBLogin(param: ["fbid":"\(user.userID)","email":user.profile.email,"phone":"","full_name":user.profile.name,"gender":"","profile_img":"\(user.profile.imageURL(withDimension: 512))","login_from":"google"])
    }
    
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
                    
                    var gender = ""
                    
                    if let gen = data.value(forKey: "gender") as? String
                    {
                        gender = gen
                    }
                    
                    print(data)
                    self.APICallFBLogin(param: ["fbid":"\(data.value(forKey: "id") as! String)","email":data.value(forKey: "email") as! String,"phone":"","full_name":data.value(forKey: "name") as! String,"gender":gender,"profile_img":"\(strpic)","login_from":"facebook"])
                    /*
                     login_from = facebook
                     login_from = twitter
                     login_from = google
                     */
                }
            })
            
            // Perform login by calling Firebase APIs
           /* Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    MBProgressHUD.hide(for: self.view, animated: true)
                    return
                }
                // Present the main view
                self.gotoTutorialView()
                
                
            })*/
            
        }
    }
    
    @IBAction func btnLoginGP(_ sender: Any) {
        KRProgressHUD.show()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func btnLoginTW(_ sender: Any) {
        
    }
    
}
//MARK: API Calling..
extension SignInVC{
    func LoginAPICall()  {
        
        var otpTo = "phone"
        
        if validateEmail(email: txtEmail.text!) != nil
        {
            otpTo = "email"
        }
        
        
        
        var tokenString = ""
        if let strtoken : NSString = UserDefaults.standard.object(forKey: "FCMToken") as? NSString{
            tokenString = strtoken as String
        }
        else{
            return
        }
        UserManager.shared.login(withEmail: txtEmail.text!, password: txtPassword.text!, FCM_Token: tokenString, email_phone : otpTo ,isremember: true) { (User, error) in
            if error != nil{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else{
                if UserManager.shared.currentUser?.role_name == "Customers"{
                    let storybord = UIStoryboard(name: "Category", bundle: nil)
                    let VC = storybord.instantiateInitialViewController()
                    AppDelegate.sharedDelegate().window?.rootViewController = VC
                    AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
                }
                else{
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
                }
            }
        }
    }
    func APICallFBLogin(param: [String:String]){
        UserManager.shared.LoginWithFB(withParam: param) { (User, error) in
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
}
