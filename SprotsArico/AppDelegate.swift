

import UIKit
import IQKeyboardManagerSwift
import KYDrawerController
import FBSDKLoginKit
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import Fabric
import Crashlytics
import FirebaseCore
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate,UNUserNotificationCenterDelegate{

    var window: UIWindow?

    var userLatitude = ""
    var userLongitude = ""
    var location_name = ""
    var timerFornotiicaiton : Timer?

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        //guard let authentication = user.authentication else { return }
        //let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,accessToken: authentication.accessToken)
        //let fullName = user.profile.name as String
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        FirebaseApp.configure()
        IQKeyboardManager.sharedManager().enable = true
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        GMSServices.provideAPIKey(Constants.gMapKey)
        GMSPlacesClient.provideAPIKey(Constants.gMapKey)
        GIDSignIn.sharedInstance().clientID = Constants.googleKey
        GIDSignIn.sharedInstance().delegate = self
        LanguageManger.shared.defaultLanguage = .en
        
        // --> Push Notification
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (_, _) in })
            Messaging.messaging().delegate = self
        }else{
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        // <-- Push Notification
        self.UserFlowSet()
        
        timerFornotiicaiton=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(AppDelegate.getToken), userInfo: nil, repeats: true)
        //UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        //UINavigationBar.appearance().barTintColor = UIColor.colorFromHex(hexString: "#DA55A1")
        //UINavigationBar.appearance().tintColor = .red
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        //UINavigationBar.appearance().isTranslucent = false
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UserDefaults.standard.set(0, forKey: "notiCount")
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication =  options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
        
        let googleHandler = GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: sourceApplication,
            annotation: annotation )
        
        let facebookHandler = FBSDKApplicationDelegate.sharedInstance().application (
            app,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation )
        
        return googleHandler || facebookHandler
    }

    class func sharedDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    //MARK:- get token :
    @objc func getToken()
    {
        if UserDefaults.standard.string(forKey: "FCMToken") != nil
        {
            // alerday added :
            timerFornotiicaiton?.invalidate()
        }
        else
        {
            if let token = InstanceID.instanceID().token() {
                print("\n\n ======  DEVICE: TOKEN " + token)
                UserDefaults.standard.setValue(token as String, forKey: "FCMToken")
            }
        }
    }
    
    func ConnectToFCM() {
        //  Messaging.messaging().shouldEstablishDirectChannel = true
        if let token = InstanceID.instanceID().token() {
            print("\n\n ======  DEVICE: TOKEN " + token)
            UserDefaults.standard.setValue(token as String, forKey: "FCMToken")
        }
        
        if let refreshedToken = InstanceID.instanceID().token() {
            print("InstanceID token: \(refreshedToken)")
        }
        // Disconnect previous FCM connection if it exists.
        Messaging.messaging().disconnect()
        
        Messaging.messaging().connect { (error) in
            if error != nil {
                print("FCM: Unable to connect with FCM. \(error.debugDescription)")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    
    func UserFlowSet() {
        var flag = false
        if ((UserDefaults.standard.value(forKey: "IsLogin") as? Bool) == nil) {
            let storybord = UIStoryboard(name: "Login", bundle: nil)
            let nav = storybord.instantiateInitialViewController()
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
            return
        }
        else if UserDefaults.standard.value(forKey: "IsLogin") as! Bool == false
        {
            flag = false
        }
        else if UserDefaults.standard.value(forKey: "IsLogin") as! Bool == true
        {
            UserManager.shared.GetUserDefaultData()
            flag = true
        }
        if flag{
            if UserManager.shared.currentUser?.role_name == "Customers"{
                var flag = false
                let storyboardmain = UIStoryboard(name: "Main", bundle: nil)
                let storyboardSocial = UIStoryboard(name: "Social", bundle: nil)
                let storyboardMarket = UIStoryboard(name: "Market", bundle: nil)
                let storyboardTraining = UIStoryboard(name: "Training", bundle: nil)
                let storyboardOffers = UIStoryboard(name: "Offers", bundle: nil)
                let storyBoardSlideMenu = UIStoryboard(name: "Menu", bundle: nil)
                if ((UserDefaults.standard.value(forKey: "IsSelectCategory") as? Bool) == nil) {
                    flag = false
                }
                else if UserDefaults.standard.value(forKey: "IsSelectCategory") as! Bool == false
                {
                    flag = false
                }
                else if UserDefaults.standard.value(forKey: "IsSelectCategory") as! Bool == true
                {
                    flag = true
                }
                if flag{
                    let selectedCategory = UserDefaults.standard.value(forKey: "Category") as! String
                    if selectedCategory == "CourtAndClub"{
                        guard let tabBarVC = storyboardmain.instantiateViewController(withIdentifier: "TabBarVC") as? TabBarVC,
                            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                                withIdentifier: "MenuVC") as? MenuVC else {
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
                    else if selectedCategory == "Social"{
                        guard let tabBarVC = storyboardSocial.instantiateViewController(withIdentifier: "SocialBarVC") as? SocialBarVC,
                            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                                withIdentifier: "MenuVC") as? MenuVC else {
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
                    else if selectedCategory == "Market"{
                        guard let tabBarVC = storyboardMarket.instantiateViewController(withIdentifier: "MarketBarVC") as? MarketBarVC,
                            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                                withIdentifier: "MenuVC") as? MenuVC else {
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
                    else if selectedCategory == "Courses"{
                        guard let tabBarVC = storyboardTraining.instantiateViewController(withIdentifier: "TrainingBarVC") as? TrainingBarVC,
                            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                                withIdentifier: "MenuVC") as? MenuVC else {
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
                    else if selectedCategory == "Offers"{
                        guard let tabBarVC = storyboardOffers.instantiateViewController(withIdentifier: "OffersBarVC") as? OffersBarVC,
                            let slideMenuViewController = storyBoardSlideMenu.instantiateViewController(
                                withIdentifier: "MenuVC") as? MenuVC else {
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
                    else{
                        
                    }
                }
                else{
                    let storybord = UIStoryboard(name: "Category", bundle: nil)
                    let VC = storybord.instantiateInitialViewController()
                    self.window?.rootViewController = VC
                }
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
        else{
            let storybord = UIStoryboard(name: "Login", bundle: nil)
            let nav = storybord.instantiateViewController(withIdentifier: "navSignIn")
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        }
    }
}
//MARK:- Push Notification
extension AppDelegate: MessagingDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print("Registration succeeded! Token: ", token)
        Messaging.messaging().apnsToken = deviceToken
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        self.ConnectToFCM()
    }
    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        print("Its Done")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if application.applicationState == .active {
            print("didFailToRegisterForRemoteNotificationsWithError = \(error)")
        }
    }
    func addBadgeNumber(_ application: UIApplication){
        let count = UserDefaults.standard.value(forKey: "notiCount") as! Int
        UserDefaults.standard.set(count + 1, forKey: "notiCount")
        application.applicationIconBadgeNumber = count + 1
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("notification result :\(userInfo)")
        //var storedata: NSMutableDictionary = NSMutableDictionary()
        //storedata=storedata.value(forKey: "aps") as! NSMutableDictionary
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(" Entire message \(userInfo)")
        print("Article avaialble for download: \(userInfo["articleId"]!)")
        
        let state : UIApplicationState = application.applicationState
        switch state {
        case UIApplicationState.active:
            print("If needed notify user about the message")
        default:
            print("Run code to download content")
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        addBadgeNumber(UIApplication.shared)
        completionHandler([.alert, .sound, .badge])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //addBadgeNumber(UIApplication.shared)
        print("Handle tapped push from background, received: \n \(response.notification.request.content)")
        print("Notification data: \(response.notification.request.content.userInfo)")
        guard (response.notification.request.content.userInfo["aps"] as? NSDictionary) != nil else { return }
        if let msg_noti = response.notification.request.content.userInfo["gcm.notification.message_details"] as? String{
            print(msg_noti)
        }
        else
        {
        }
        completionHandler()
    }
    func application(received remoteMessage: MessagingRemoteMessage) {
        //addBadgeNumber(UIApplication.shared)
        //print(remoteMessage.appData)
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
        // Convert to pretty-print JSON, just to show the message for testing
//        guard let data = try? JSONSerialization.data(withJSONObject: remoteMessage.appData, options: .prettyPrinted),
//            let prettyPrinted = String(data: data, encoding: .utf8) else {
//                return
//        }
        //print("Received direct channel message:\n\(prettyPrinted)")
        NotificationCenter.default.post(name: .didReceiveData, object: nil, userInfo: remoteMessage.appData)
    }
}
