

import UIKit
import CoreLocation

class CategoriesVC: UIViewController {

    
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
                   /* print(placemarks?.country)
                    print(placemarks?.locality)
                    print(placemarks?.subLocality)
                    print(placemarks?.thoroughfare)
                    print(placemarks?.postalCode)
                    print(placemarks?.subThoroughfare)
 */
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
                    let defaults = UserDefaults.standard
                    defaults.set(addressString, forKey: "LocationName")
                    defaults.set("\(location?.coordinate.latitude ?? 0.0)", forKey: "lat")
                    defaults.set("\(location?.coordinate.longitude ?? 0.0)", forKey: "long")
                    defaults.synchronize()
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCourtAndClub(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "IsSelectCategory")
        UserDefaults.standard.set("CourtAndClub", forKey: "Category")
        UserDefaults.standard.synchronize()
        var flag = false
        if ((UserDefaults.standard.value(forKey: "IsSelectPreSport") as? Bool) == nil) {
            flag = false
        }
        else if UserDefaults.standard.value(forKey: "IsSelectPreSport") as! Bool == false
        {
            flag = false
        }
        else if UserDefaults.standard.value(forKey: "IsSelectPreSport") as! Bool == true
        {
            flag = true
        }
        if flag{
            ChangeCategoryClass.shared.OpenCourtVC()
        }
        else{
            let storybord = UIStoryboard(name: "Category", bundle: nil)
            let VC = storybord.instantiateViewController(withIdentifier: "SelectPreferredSportVC") as! SelectPreferredSportVC
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    @IBAction func btnMarket(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "IsSelectCategory")
        UserDefaults.standard.set("Market", forKey: "Category")
        UserDefaults.standard.synchronize()
        ChangeCategoryClass.shared.OpenMarketVC()
    }
    @IBAction func btnCourses(_ sender: Any){
        UserDefaults.standard.set(true, forKey: "IsSelectCategory")
        UserDefaults.standard.set("Courses", forKey: "Category")
        UserDefaults.standard.synchronize()
        ChangeCategoryClass.shared.OpenTrainingVC()
    }
    @IBAction func btnOffers(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "IsSelectCategory")
        UserDefaults.standard.set("Offers", forKey: "Category")
        UserDefaults.standard.synchronize()
        ChangeCategoryClass.shared.OpenOffersVC()
    }
    @IBAction func btnSocial(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "IsSelectCategory")
        UserDefaults.standard.set("Social", forKey: "Category")
        UserDefaults.standard.synchronize()
        ChangeCategoryClass.shared.OpenSocialVC()
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
