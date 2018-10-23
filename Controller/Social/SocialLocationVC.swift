

import UIKit
import GoogleMaps

class SocialLocationVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var mapView: GMSMapView!
    
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(Double(AppDelegate.sharedDelegate().userLatitude) ?? 0.0)
        print(Double(AppDelegate.sharedDelegate().userLongitude) ?? 0.0)
        let camera = GMSCameraPosition.camera(withLatitude: Double(AppDelegate.sharedDelegate().userLatitude) ?? 0.0, longitude: Double(AppDelegate.sharedDelegate().userLongitude) ?? 0.0, zoom: 15)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(AppDelegate.sharedDelegate().userLatitude) ?? 0.0, longitude: Double(AppDelegate.sharedDelegate().userLongitude) ?? 0.0)
        mapView.camera = camera
        marker.map = mapView
        
        // Do any additional setup after loading the view.
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

}
