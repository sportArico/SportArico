

import UIKit
import GooglePlaces

class resentSearchCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
}

class SearchLocationVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var lblAreaName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblRecentLocation: UITableView!
    // === End ===//
    
    //MARK: Variable
    var OnSave: ((_ Param: [String:String]) -> ())?
    var ResentSearchArray:[[String:String]] = []
    //==== End ===//
    
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
                    self.searchBar.text = addressString
                    let defaults = UserDefaults.standard
                    defaults.set(addressString, forKey: "LocationName")
                    defaults.set("\(location?.coordinate.latitude ?? 0.0)", forKey: "lat")
                    defaults.set("\(location?.coordinate.longitude ?? 0.0)", forKey: "long")
                    defaults.synchronize()
                    self.PopoToBack()
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
        self.lblAreaName.text = AppDelegate.sharedDelegate().location_name
        var category_id = ""
        let selectedCategory = UserDefaults.standard.value(forKey: "Category") as! String
        if selectedCategory == "CourtAndClub"{
            category_id = "1"
        }
        else if selectedCategory == "Social"{
            category_id = "5"
        }
        else if selectedCategory == "Market"{
            category_id = "3"
        }
        else if selectedCategory == "Courses"{
            category_id = "2"
        }
        else if selectedCategory == "Offers"{
            category_id = "4"
        }
        else{
            category_id = ""
        }
        let param:[String:String] = ["category_id":category_id,"user_id":(UserManager.shared.currentUser?.user_id)!]
        CourtAndClubManager.shared.ResentSearchLocation(param: param) { (ArrayResentSearch, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
                return
            }
            else if (ArrayResentSearch?.count)! > 0{
                self.ResentSearchArray = ArrayResentSearch!
                self.tblRecentLocation.delegate = self
                self.tblRecentLocation.dataSource = self
                self.tblRecentLocation.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no resent search data", controller: self)
            }
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCurrentLocation(_ sender: Any) {
        self.GetLocationAndAPICall()
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func PopoToBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let param = ["latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"search_text":AppDelegate.sharedDelegate().location_name]
            self.OnSave?(param)
            self.navigationController?.popViewController(animated: true)
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

extension SearchLocationVC: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
}
extension SearchLocationVC: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        searchBar.resignFirstResponder()
        searchBar.text = place.name
        print(place.coordinate.latitude)
        print(place.coordinate.longitude)
        AppDelegate.sharedDelegate().userLatitude = "\(place.coordinate.latitude)"
        AppDelegate.sharedDelegate().userLongitude = "\(place.coordinate.longitude)"
        AppDelegate.sharedDelegate().location_name = place.name
        dismiss(animated: true, completion: nil)
        self.PopoToBack()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
//MARK: API Call
extension SearchLocationVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ResentSearchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "resentSearchCell", for: indexPath) as? resentSearchCell else {
            return UITableViewCell()
        }
        cell.lblName.text = self.ResentSearchArray[indexPath.row]["search_text"] ?? ""
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AppDelegate.sharedDelegate().location_name = self.ResentSearchArray[indexPath.row]["search_text"] ?? ""
        let param = ["latitude":"","longitude":"","search_text": self.ResentSearchArray[indexPath.row]["search_text"] ?? ""]
        self.OnSave?(param)
        self.navigationController?.popViewController(animated: true)
    }
}
