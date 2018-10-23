
import UIKit
import KYDrawerController
import GoogleMaps

class LocationNearMeVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var CollView: UICollectionView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var ShowMapView: GMSMapView!
    //=== End === //
    
    //MARK: Variable
    var ArrayNearByLocation:[NearByLocationData] = []
    //=== End ==//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(AppDelegate.sharedDelegate().userLatitude) ?? 0.0, longitude: Double(AppDelegate.sharedDelegate().userLongitude) ?? 0.0, zoom: 6.0)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(AppDelegate.sharedDelegate().userLatitude) ?? 0.0, longitude: Double(AppDelegate.sharedDelegate().userLongitude) ?? 0.0)
        ShowMapView.camera = camera
        marker.map = ShowMapView
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.APICallNearByCourt(lat: AppDelegate.sharedDelegate().userLatitude, long: AppDelegate.sharedDelegate().userLongitude)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
        
    }
    
    @IBAction func btnUser(_ sender: Any) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "MyProfileVC") as! MyProfileVC
        present(VC, animated: true, completion: nil)
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
extension LocationNearMeVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  110
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/1, height: 140)
    }
}
extension LocationNearMeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ArrayNearByLocation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationAndNearMeCell", for: indexPath) as! LocationAndNearMeCell
        let obj = self.ArrayNearByLocation[indexPath.row]
        let img = obj.images
        if img!.count > 0{
            print(img![0].image!)
            cell.imgImage.sd_setImage(with: URL.init(string: img![0].image!), completed: nil)
        }
        cell.imgImage.contentMode = .scaleAspectFill
        cell.imgImage.clipsToBounds = true
        cell.lblName.text = obj.courtTitle
        cell.lblReviewCount.text = String(describing: obj.rating!)
        cell.lblDistance.text = "  \u{25CF} \(Double(obj.distance ?? "")?.rounded() ?? 0.0)km from you"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "LocationDetailVC") as! LocationDetailVC
        VC.Name = self.ArrayNearByLocation[indexPath.row].courtTitle!
        VC.CourtId = self.ArrayNearByLocation[indexPath.row].courtId!
        navigationController?.pushViewController(VC, animated: true)
    }
 
    
}

//MARK: API Calling...
extension LocationNearMeVC{
    func APICallNearByCourt(lat: String, long: String) {
        
        CourtAndClubManager.shared.GetNearbyCourt(lat: lat, long: long) { (NearByLocationData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if NearByLocationData.count > 0{
                self.ArrayNearByLocation = NearByLocationData as! [NearByLocationData]
                self.CollView.delegate = self
                self.CollView.dataSource = self
                self.CollView.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
        }
    }
}
