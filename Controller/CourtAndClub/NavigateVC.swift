

import UIKit
import GoogleMaps
import Alamofire
import KRProgressHUD

class NavigateVC: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var Array:[String:Any] = [:]
    var CourtDetailData:CourtDetailData?
    var TrainingSportDetailData:TrainingDetailData?
    var MarketProductDetail:MarketProductDetailData?
    var locationManager = CLLocationManager()
    
    var marker = GMSMarker()
    var sessionManager = SessionManager()
    var MapType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.mapView.isMyLocationEnabled = true
        LocationManager.sharedInstance.getLocation { (location:CLLocation?, error:NSError?) in
            if error != nil {
                Utility.setAlertWith(title: "Alert", message: error?.localizedDescription, controller: self)
                return
            }
            guard location != nil else {
                Utility.setAlertWith(title: "Alert", message: "Unable to fetch location", controller: self)
                return
            }
            var end = CLLocationCoordinate2D()
            if self.MapType == "court"{
                end = CLLocationCoordinate2D(latitude: Double(self.CourtDetailData?.latitude ?? "")!, longitude: Double(self.CourtDetailData?.longitude ?? "")!)
            }
            else if self.MapType == "cources"{
                end = CLLocationCoordinate2D(latitude: Double(self.TrainingSportDetailData?.latitude ?? "")!, longitude: Double(self.TrainingSportDetailData?.longitude ?? "")!)
            }
            else if self.MapType == "market"{
                end = CLLocationCoordinate2D(latitude: Double(self.MarketProductDetail?.providerInfo?.first?.latitude ?? "")!, longitude: Double(self.MarketProductDetail?.providerInfo?.first?.longitude ?? "")!)
            }
            else{
                
            }
            self.DrawPoliyLine(start: location?.coordinate, end: end)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    func DrawPoliyLine(start: CLLocationCoordinate2D?,end: CLLocationCoordinate2D?)  {
        sessionManager.requestDirections(from: start!, to: end!, completionHandler: { (path, error) in
            if let error = error {
                print("Something went wrong, abort drawing!\nError: \(error)")
            } else {
                self.showMarker(position: start!, title: "")
                self.showMarker(position: end!, title: "")
                
                // Create a GMSPolyline object from the GMSPath
                let polyline = GMSPolyline(path: path!)
                // Add the GMSPolyline object to the mapView
                polyline.map = self.mapView
                polyline.strokeWidth = 2.0
                polyline.strokeColor = .black
                // Move the camera to the polyline
                let bounds = GMSCoordinateBounds(path: path!)
                let cameraUpdate = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 40, left: 15, bottom: 10, right: 15))
                self.mapView.animate(with: cameraUpdate)
                
                //MARK: Start Camera Move...
                self.locationManager.delegate = self
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
            }
        })
    }
    
    func showMarker(position: CLLocationCoordinate2D,title: String){
        let marker = GMSMarker()
        marker.position = position
        marker.title = title
        //marker.snippet = "San Francisco"
        //marker.isDraggable = true
        marker.map = mapView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnArriveNow(_ sender: Any) {
        
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
extension NavigateVC:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        
        let center = CLLocationCoordinate2D(latitude: userLocation!.coordinate.latitude, longitude: userLocation!.coordinate.longitude)
        let camera = GMSCameraPosition.camera(withLatitude: userLocation!.coordinate.latitude,
                                              longitude: userLocation!.coordinate.longitude, zoom: 13.0)
        //mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        //mapView.isMyLocationEnabled = true
        self.marker.position = center
        self.marker.icon = GMSMarker.markerImage(with: UIColor.green)
        self.marker.map = mapView
        self.mapView.animate(to: camera)
        //locationManager.stopUpdatingLocation()
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.authorizedWhenInUse)
        {
            mapView.isMyLocationEnabled = true
        }
    }
}

