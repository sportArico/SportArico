

import UIKit
import CoreLocation
import KYDrawerController

class ProviderHomeVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var lblMyPitch: UILabel!
    @IBOutlet weak var lblBooking: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    //=== End ===//

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.GetLocationAndAPICall()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print(UserManager.shared.currentUser?.user_id as Any)
        self.APIGetDashBoard(user_id: (UserManager.shared.currentUser?.user_id)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    @IBAction func btnLogout(_ sender: Any) {
        let Loginstorybord = UIStoryboard(name: "Login", bundle: nil)
        let nav = Loginstorybord.instantiateInitialViewController()
        AppDelegate.sharedDelegate().window?.rootViewController = nav
        AppDelegate.sharedDelegate().window?.makeKeyAndVisible()
    }
    
    @IBAction func btnMyPitch(_ sender: Any) {
        let Providerstorybord = UIStoryboard(name: "Provider", bundle: nil)
        let VC = Providerstorybord.instantiateViewController(withIdentifier: "MyPitchesVC") as! MyPitchesVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnBooking(_ sender: Any) {
        
    }
    @IBAction func btnReview(_ sender: Any) {
        let Providerstorybord = UIStoryboard(name: "Provider", bundle: nil)
        let VC = Providerstorybord.instantiateViewController(withIdentifier: "MyPitchesVC") as! MyPitchesVC
        VC.isReview = true
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnAvailbleBalance(_ sender: Any) {
        
    }
    @IBAction func btnUpgrade(_ sender: Any) {
        
    }
    @IBAction func btnNotification(_ sender: Any) {
        let Providerstorybord = UIStoryboard(name: "Provider", bundle: nil)
        let VC = Providerstorybord.instantiateViewController(withIdentifier: "ProviderNotificationListVC") as! ProviderNotificationListVC
        navigationController?.pushViewController(VC, animated: true)
    }
}
extension ProviderHomeVC{
    func APIGetDashBoard(user_id: String)  {
        ProviderManager.shared.GetProviderDashboard(UserId: user_id) { (ProviderDetail, error) in
            if ProviderDetail != nil{
                
                self.lblMyPitch.text = "My Pitch \(ProviderDetail?.value(forKey: "my_pitch") as? Int ?? 0)"
                self.lblPrice.text = "AED \(ProviderDetail?.value(forKey: "available_balance") as? String ?? "")"
                self.lblBooking.text = "Booking \(ProviderDetail?.value(forKey: "booking_count") as? Int ?? 0)"
                
            }
            else {
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}
//MARK: Get Location
extension ProviderHomeVC{
    fileprivate func GetLocationAndAPICall() {
        LocationManager.sharedInstance.getLocation { (location:CLLocation?, error:NSError?) in
            if error != nil {
                self.CheckLocationPermision()
                //Utility.setAlertWith(title: "Error", message: (error?.localizedDescription)!, controller: self)
                return
            }
            guard let _ = location else {
                Utility.setAlertWith(title: "Error", message: "Unable to fetch location", controller: self)
                return
            }
            AppDelegate.sharedDelegate().userLatitude = "\((location?.coordinate.latitude)!)"
            AppDelegate.sharedDelegate().userLongitude = "\((location?.coordinate.longitude)!)"
            if (AppDelegate.sharedDelegate().userLatitude != "" && AppDelegate.sharedDelegate().userLongitude != "" )
            {
                LocationManager.sharedInstance.getReverseGeoCodedLocation(location: location!, completionHandler: { (location, placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    print(placemarks?.country)
                    print(placemarks?.locality)
                    print(placemarks?.subLocality)
                    print(placemarks?.thoroughfare)
                    print(placemarks?.postalCode)
                    print(placemarks?.subThoroughfare)
                    var addressString : String = ""
                    if placemarks?.subLocality != nil {
                        addressString = addressString + (placemarks?.subLocality!)! + ", "
                    }
                    //                    if placemarks?.thoroughfare != nil {
                    //                        addressString = addressString + (placemarks?.thoroughfare!)! + ", "
                    //                    }
                    if placemarks?.locality != nil {
                        addressString = addressString + (placemarks?.locality!)!
                    }
                    //                    if placemarks?.country != nil {
                    //                        addressString = addressString + (placemarks?.country!)! + ", "
                    //                    }
                    //                    if placemarks?.postalCode != nil {
                    //                        addressString = addressString + (placemarks?.postalCode!)! + " "
                    //                    }
                    AppDelegate.sharedDelegate().location_name = addressString
                })
            }
        }
    }
    fileprivate func CheckLocationPermision() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                let alert = UIAlertController(title: "Location Services Disabled", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Go to Settings now", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                    UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
                }))
                self.present(alert, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                self.GetLocationAndAPICall()
                break
            }
        } else {
            print("Location services are not enabled")
            let alert = UIAlertController(title: "Location Services Disabled", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Go to Settings now", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                    UIApplication.shared.openURL(url)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
