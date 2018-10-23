

import UIKit
import FBSDKLoginKit
import KRProgressHUD
import GoogleSignIn

class TutorialVC: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var orderedViewControllers: [UIViewController] = []
    var pageControl = UIPageControl()
    var Button = UIButton()
    var ButtonFB = UIButton()
    var ButtonTW = UIButton()
    var SignInORSignUp = UIButton()
    var signUpButton = UIButton()
    var BottomImage = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.dataSource = self
        self.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
        
        let firstViewController : FirestTutorialController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "FirestTutorialController") as! FirestTutorialController
        firstViewController.parentView = self
        
        let secondViewController : SecondTutorialController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SecondTutorialController") as! SecondTutorialController
        secondViewController.parentView = self
        let thirdViewController : ThirdTutorialController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ThirdTutorialController") as! ThirdTutorialController
        orderedViewControllers.append(firstViewController)
        orderedViewControllers.append(secondViewController)
        orderedViewControllers.append(thirdViewController)
        
        
        
        UserManager.shared.getChatText { (dictArr) in
            secondViewController.chatData = dictArr
            secondViewController.tableview?.reloadData()
        }
        
        
        
        
        
        
        
        
        configurePageControl()
        //configureButton()
        configureButtonSignInorSignUp()
        configureBottomImage()
        pageControl.layer.position.y = self.view.frame.height - 115
        SignInORSignUp.layer.position.y = self.view.frame.height - 30
        BottomImage.layer.position.y = self.view.frame.height - 5
        // This sets up the first view that will show up on our page control
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
        pageControl.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(gesture:)))
        swipeUP.direction = UISwipeGestureRecognizerDirection.up
        self.view.addGestureRecognizer(swipeUP)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        updatePageControl()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "navSignIn")
                vc.view.backgroundColor = .clear
                vc.modalPresentationStyle = .overCurrentContext
                present(vc, animated: true, completion: nil)
            default:
                break
            }
        }
    }
    // PageView Controller Delegate
    func newVc(viewController: String) -> UIViewController {
        let controller : UIViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: viewController)
        
        return controller
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            //            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            //            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
        updatePageControl()
        
    }
    
    // PageControl Part
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 115,width: UIScreen.main.bounds.width,height: 20))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor(red: 103, green: 25, blue: 155)
        self.pageControl.pageIndicatorTintColor = UIColor(red: 103, green: 25, blue: 155)
        self.pageControl.currentPageIndicatorTintColor = UIColor(red: 103, green: 25, blue: 155)
        self.view.addSubview(pageControl)
    }
    // Button Configration
    func configureButton() {
        Button.setImage(#imageLiteral(resourceName: "google-plus"), for: .normal)
        Button.addTarget(self, action: #selector(buttonActionGP), for: .touchUpInside)
        self.view.addSubview(Button)
        Button.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.view.layoutMarginsGuide
        let m = self.pageControl.layoutMarginsGuide
        //Button.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        //Button.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        Button.centerXAnchor.constraint(equalTo: m.centerXAnchor).isActive = true
        Button.topAnchor.constraint(equalTo: m.topAnchor, constant: 15).isActive = true
        Button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        Button.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        ButtonTW.setImage(#imageLiteral(resourceName: "twitter"), for: .normal)
        ButtonTW.addTarget(self, action: #selector(buttonActionTW), for: .touchUpInside)
        self.view.addSubview(ButtonTW)
        ButtonTW.translatesAutoresizingMaskIntoConstraints = false
        //Button.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 0).isActive = true
        ButtonTW.centerYAnchor.constraint(equalTo: Button.centerYAnchor).isActive = true
        ButtonTW.leadingAnchor.constraint(equalTo: Button.leadingAnchor, constant: 75).isActive = true
        ButtonTW.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ButtonTW.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        ButtonFB.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        ButtonFB.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(ButtonFB)
        ButtonFB.translatesAutoresizingMaskIntoConstraints = false
        ButtonFB.centerYAnchor.constraint(equalTo: Button.centerYAnchor).isActive = true
        ButtonFB.trailingAnchor.constraint(equalTo: Button.trailingAnchor, constant: -75).isActive = true
        ButtonFB.heightAnchor.constraint(equalToConstant: 45).isActive = true
        ButtonFB.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
    }
    func configureButtonSignInorSignUp() {
        SignInORSignUp = UIButton(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 30,width: UIScreen.main.bounds.width,height: 25))
        SignInORSignUp.backgroundColor = UIColor.white
        SignInORSignUp.clipsToBounds = true
        SignInORSignUp.setTitle("Sign In or Sign up", for: .normal)
        SignInORSignUp.setTitleColor(UIColor.black, for: .normal)
        SignInORSignUp.titleLabel?.font =  UIFont.systemFont(ofSize: 12)
        SignInORSignUp.addTarget(self, action: #selector(btnSignInOrSignUp), for: .touchUpInside)
        self.view.addSubview(SignInORSignUp)
        
        
         signUpButton = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width * 0.5) - (UIScreen.main.bounds.width * 0.25) ,y: UIScreen.main.bounds.maxY - SignInORSignUp.frame.height - 70,width: UIScreen.main.bounds.width * 0.5,height: 40))
        signUpButton.backgroundColor = UIColor.white
        signUpButton.clipsToBounds = true
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.setTitleColor(UIColor.black, for: .normal)
        signUpButton.titleLabel?.font =  UIFont.systemFont(ofSize: 17)
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.layer.masksToBounds = true
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.borderWidth = 1
        signUpButton.addTarget(self, action: #selector(btnSignUp), for: .touchUpInside)
        self.view.addSubview(signUpButton)
        
        
        
    }
    func configureBottomImage() {
        BottomImage = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width / 2) - 10,y: UIScreen.main.bounds.maxY - 5,width: 20,height: 20))
        BottomImage.image = #imageLiteral(resourceName: "bottom_arrow")
        BottomImage.clipsToBounds = true
        BottomImage.contentMode = .scaleAspectFit
        self.view.addSubview(BottomImage)
    }
    
    @objc func buttonActionGP(sender: UIButton!) {
        KRProgressHUD.show()
        GIDSignIn.sharedInstance().signIn()
    }
    @objc func buttonActionTW(sender: UIButton!) {
        
        
        
    }
    @objc func buttonAction(sender: UIButton!) {
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
    
    @objc func btnSignUp(sender: UIButton!) {
        
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectSignUpVC")
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
        //navigationController?.pushViewController(vc, animated: true)
        
//        let storybord = UIStoryboard(name: "Login", bundle: nil)
//        let VC = storybord.instantiateViewController(withIdentifier: "SelectSignUpVC") as! SelectSignUpVC
//        navigationController?.pushViewController(VC, animated: true)
        
    }
    
    @objc func btnSignInOrSignUp(sender: UIButton!) {
        print("Button tapped")
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "navSignIn")
        vc.view.backgroundColor = .clear
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    func updatePageControl() {
        for (index, dot) in pageControl.subviews.enumerated() {
            if index == pageControl.currentPage {
                dot.backgroundColor = UIColor(red: 103, green: 25, blue: 155)
                dot.layer.borderColor = UIColor.gray.cgColor
                dot.layer.cornerRadius = dot.frame.size.height / 2;
                dot.layer.borderWidth = 0.5
            } else {
                dot.backgroundColor = UIColor.lightGray
                dot.layer.cornerRadius = dot.frame.size.height / 2
                dot.layer.borderColor = UIColor.gray.cgColor
                dot.layer.borderWidth = 0.5
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
}
extension TutorialVC{
    func goToNextPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else { return }
        setViewControllers([nextViewController], direction: .forward, animated: animated, completion: nil)
        self.pageControl.currentPage = self.pageControl.currentPage + 1
        self.updatePageControl()
    }
    func goToPreviousPage(animated: Bool = true) {
        guard let currentViewController = self.viewControllers?.first else { return }
        guard let previousViewController = dataSource?.pageViewController(self, viewControllerBefore: currentViewController) else { return }
        setViewControllers([previousViewController], direction: .reverse, animated: animated, completion: nil)
    }
    
}
//MARK: API Calling..
extension TutorialVC{
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

