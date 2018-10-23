

import UIKit
import TTTAttributedLabel
import FBSDKLoginKit
import KRProgressHUD
import GoogleSignIn

class SignUpNewVC: UIViewController,TTTAttributedLabelDelegate, GIDSignInUIDelegate, GIDSignInDelegate {

    @IBOutlet weak var lblTC: TTTAttributedLabel!
    override func viewDidLoad() {
        super.viewDidLoad()

//        var range:Range = ((lblTC.text?.range(of: "Term and Condition")!))!
//        lblTC.addLink(to: URL(string: "www.google.com")!, with: range)
//
//        range = (lblTC.text?.range(of: "Privacy Statement"))!
//        lblTC.addLink(to: URL(string: "www.google.com")!, with: range)

       setupTC()
        
    }
    
    
    @IBAction func onFbLogin(_ sender: UIButton) {
       
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
                    self.APICallFBLogin(param: ["fbid":"\(data.value(forKey: "id") as! String)","email":data.value(forKey: "email") as! String,"phone":"","full_name":data.value(forKey: "name") as! String,"gender":data.value(forKey: "gender") as! String,"profile_img":"\(strpic)","login_from":"facebook"])
                   
                }
            })
        }
    }
    
    @IBAction func onGoogleLogin(_ sender: UIButton) {
        
        KRProgressHUD.show()
        GIDSignIn.sharedInstance().signIn()
        GIDSignIn.sharedInstance().delegate = self
        
    }
    
    
    @IBAction func onSignInEmail(_ sender: UIButton) {
        
        let storybord = UIStoryboard(name: "Login", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SignInVC") as! SelectSignUpVC
        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @IBAction func onSignUp(_ sender: UIButton) {
        
        let storybord = UIStoryboard(name: "Login", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SelectSignUpVC") as! SelectSignUpVC
        navigationController?.pushViewController(VC, animated: true)
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
        print(user.profile.name)
        print(user.profile.email)
        print(user.profile.imageURL(withDimension: 512))
        print(user.userID)
        //MARK: Login Done.
        self.APICallFBLogin(param: ["fbid":"\(user.userID)","email":user.profile.email,"phone":"","full_name":user.profile.name,"gender":"","profile_img":"\(user.profile.imageURL(withDimension: 512))","login_from":"google"])
    }
    

    func setupTC(){
        lblTC.numberOfLines = 0;
        
        let strTC = "Terms and Conditions"
        let strPP = "Privacy Policy"
        
        let string = "By signing up or logging in, you agree to our \(strTC) and \(strPP)"
        
        let nsString = string as NSString
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.2
        
        let fullAttributedString = NSAttributedString(string:string, attributes: [
            NSAttributedStringKey.paragraphStyle: paragraphStyle,
            NSAttributedStringKey.foregroundColor: UIColor.black.cgColor,
            ])
        lblTC.textAlignment = .center
        lblTC.attributedText = fullAttributedString;
        
        let rangeTC = nsString.range(of: strTC)
        let rangePP = nsString.range(of: strPP)
        
        let ppLinkAttributes: [String: Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.black.cgColor,
            NSAttributedStringKey.underlineStyle.rawValue: true,
            ]
        let ppActiveLinkAttributes: [String: Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.black.cgColor,
            NSAttributedStringKey.underlineStyle.rawValue: true,
            ]
        
        lblTC.activeLinkAttributes = ppActiveLinkAttributes
        lblTC.linkAttributes = ppLinkAttributes
        
        let urlTC = URL(string: "action://TC")!
        let urlPP = URL(string: "action://PP")!
        lblTC.addLink(to: urlTC, with: rangeTC)
        lblTC.addLink(to: urlPP, with: rangePP)
        
        lblTC.textColor = UIColor.black;
        lblTC.delegate = self;
    }
    
    func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
        if url.absoluteString == "action://TC" {
            print("TC click")
        }
        else if url.absoluteString == "action://PP" {
            print("PP click")
        }
    }

}


//MARK: API Calling..
extension SignUpNewVC{
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
