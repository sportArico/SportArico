

import UIKit
import CoreLocation

class SelectLanguageVC: UIViewController {
    
    
    //MARK: Outlet
    @IBOutlet weak var btnEnglish: UIButton!
    @IBOutlet weak var btnArabic: UIButton!
    @IBOutlet weak var lblWelcome: UILabel!
    // === End === //
    
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
                        var addressString : String = ""
                    if placemarks?.subLocality != nil {
                        addressString = addressString + (placemarks?.subLocality!)! + ", "
                        }
//                    if placemarks?.thoroughfare != nil {
//                        addressString = addressString + (placemarks?.thoroughfare!)! + ", "
//                        }
                    if placemarks?.locality != nil {
                        addressString = addressString + (placemarks?.locality!)!
                        }
//                    if placemarks?.country != nil {
//                        addressString = addressString + (placemarks?.country!)! + ", "
//                        }
//                    if placemarks?.postalCode != nil {
//                        addressString = addressString + (placemarks?.postalCode!)! + " "
//                        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.GetLocationAndAPICall()
        self.lblWelcome.text = "العربية"
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if btnArabic.currentTitle == "عربى"{
            LanguageManger.shared.setLanguage(language: .ar)
        }
        else{
            LanguageManger.shared.setLanguage(language: .en)
        }
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "TutorialVC")
        UIView.transition(with: AppDelegate.sharedDelegate().window!, duration: 0.3, options: .curveEaseOut, animations: {
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }, completion: { completed in
            // maybe do something here
        })
    }
    
    @IBAction func btnEnglish(_ sender: Any) {
       /* let alert = UIAlertController(title: "Alert", message: "Are you sure continue with English Language.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            LanguageManger.shared.setLanguage(language: .en)
        }))
        self.present(alert, animated: true, completion: nil)
        */
    }
    
    @IBAction func btnArabic(_ sender: Any) {
        /*
        let alert = UIAlertController(title: "Alert", message: "Are you sure continue with English Arabic.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
            LanguageManger.shared.setLanguage(language: .ar)
        }))
        self.present(alert, animated: true, completion: nil)
*/
    }
    @IBAction func btnScrollLang(_ sender: Any) {
        if btnArabic.currentTitle == "عربى"{
            btnEnglish.setTitle("عربى", for: .normal)
            btnEnglish.contentHorizontalAlignment = .right
            btnArabic.setTitle("English", for: .normal)
            btnArabic.contentHorizontalAlignment = .left
            self.lblWelcome.text = "Welcome"
        }
        else{
            btnArabic.setTitle("عربى", for: .normal)
            btnEnglish.setTitle("English", for: .normal)
            btnEnglish.contentHorizontalAlignment = .left
            btnArabic.contentHorizontalAlignment = .right
            self.lblWelcome.text = "العربية"
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
