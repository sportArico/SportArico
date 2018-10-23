

import UIKit
import KYDrawerController
import CoreLocation

class CourtVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var lblLocationName: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnFillter: UIButton!
    @IBOutlet weak var tblCourt: UITableView!
    @IBOutlet weak var btnFire: UIButton!
    //=== End ==//
    
    //MARK: Variable
    var width = 0
    let Screenwidth = UIScreen.main.bounds.size.width
    var ArrayCourtList:[CourtHomeData] = []
    
    //=== End == //

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCourt.register(UINib(nibName: "CourtCell", bundle: nil), forCellReuseIdentifier: "CourtCell")
          let param = ["category_id":"1","sport_ids":"","latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"distance":"","price_range_end":"","price_range_start":"","search_text":AppDelegate.sharedDelegate().location_name,"is_handicap":"0","user_id":UserManager.shared.currentUser?.user_id,"location":AppDelegate.sharedDelegate().location_name]
        print(param)
        self.APICallGetCourtList(Param: param as! [String : String])
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblLocationName.text = AppDelegate.sharedDelegate().location_name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action Method
    @IBAction func btnMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    @IBAction func btnFillter(_ sender: Any) {
//        let storybord = UIStoryboard(name: "Main", bundle: nil)
//        let VC = storybord.instantiateViewController(withIdentifier: "CourtPreferenceVC") as! CourtPreferenceVC
//        navigationController?.pushViewController(VC, animated: true)
        //performSegue(withIdentifier: "Filtter", sender: nil)
    }
    
    @IBAction func btnFire(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "ChangeCategoryVC") as! ChangeCategoryVC
        ivc.modalPresentationStyle = .overCurrentContext
        ivc.modalTransitionStyle = .coverVertical
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Filtter"{
            let popview = segue.destination as! CourtPreferenceVC
            popview.OnSave = { (Param) in
                print(Param)
                self.APICallGetCourtList(Param: Param)
            }
        }
        else if segue.identifier == "SearchLocation"{
            let popview = segue.destination as! SearchLocationVC
            popview.OnSave = { (Param) in
                print(Param)
                let param = ["category_id":"1","sport_ids":"","latitude":Param["latitude"]!,"longitude":Param["longitude"]!,"distance":"","price_range_end":"","price_range_start":"","search_text":Param["search_text"]!,"user_id":UserManager.shared.currentUser?.user_id,"location":Param["search_text"]!]
                self.APICallGetCourtList(Param: param as! [String : String])
            }
        }
    }
 

}
//MARK: Tablview Delegete and Datasource Method
extension CourtVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.ArrayCourtList.count == 0 {
            self.tblCourt.setEmptyMessage("No matches found for selected criteria")
        } else {
            self.tblCourt.restore()
        }
        
        return self.ArrayCourtList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "CourtCell", for: indexPath) as! CourtCell
        Cell.lblCourtName.text = self.ArrayCourtList[indexPath.row].courtTitle
        Cell.lblPrice.text = "\(self.ArrayCourtList[indexPath.row].price ?? "") AED"
        Cell.PriceWidth.constant = Cell.lblPrice.intrinsicContentSize.width + 5
        //My location
        let myLocation = CLLocation(latitude: Double(AppDelegate.sharedDelegate().userLatitude) ?? 0.0, longitude: Double(AppDelegate.sharedDelegate().userLongitude) ?? 0.0)
        //My buddy's location
        let myBuddysLocation = CLLocation(latitude: Double(self.ArrayCourtList[indexPath.row].latitude ?? "0.0") ?? 0.0, longitude: Double(self.ArrayCourtList[indexPath.row].longitude ?? "0.0") ?? 0.0)
        //Measuring my distance to my buddy's (in km)
        let distance = myLocation.distance(from: myBuddysLocation) / 1000
        
        //Display the result in km
        print(String(format: "The distance to my buddy is %.01fkm", distance))
        Cell.lblDistance.text = "\(self.ArrayCourtList[indexPath.row].location ?? "")" + " \(String(format: "%.01fkm from you", distance))"
        Cell.lblRating.text = "\(self.ArrayCourtList[indexPath.row].rating ?? 0)"
        Cell.StarView.rating = Double(self.ArrayCourtList[indexPath.row].rating ?? 0)
        if self.ArrayCourtList[indexPath.row].isRecommended == "0"{
            Cell.isRecommendedView.isHidden = true
        }
        else{
            Cell.isRecommendedView.isHidden = false
        }
        //Cell.imgBGImavar width = 0
        for image in self.ArrayCourtList[indexPath.row].images!{
            if width == 0{
                width = 35
            }
            else{
                width += 35
            }
            let imageView = UIImageView(frame: CGRect(x: width, y: 0, width: 25, height: 25))
            imageView.sd_setImage(with: URL.init(string: image.image!), completed: nil)
            imageView.contentMode = .scaleAspectFill
            imageView.cornerRadius = imageView.layer.frame.height / 2
            imageView.clipsToBounds = true
            Cell.AddimageView.addSubview(imageView)
            Cell.imgBGImage.sd_setImage(with: URL.init(string: image.image!), completed: nil)
        }
        self.width = 0
        return Cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "LocationDetailVC") as! LocationDetailVC
        VC.CourtId = self.ArrayCourtList[indexPath.row].courtId!
        VC.Name = self.ArrayCourtList[indexPath.row].courtTitle!
        navigationController?.pushViewController(VC, animated: true)
    }
    
}
//MARK: API Calling...
extension CourtVC{
    func APICallGetCourtList(Param: [String:String]) {
        CourtAndClubManager.shared.GetCourtHomeList(Param: Param) { (CourtListData, error) in
            self.tblCourt.delegate = self
            self.tblCourt.dataSource = self
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
                self.tblCourt.reloadData()
            }
            else if CourtListData.count > 0{
                self.ArrayCourtList = CourtListData as! [CourtHomeData]
                self.tblCourt.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
                self.ArrayCourtList.removeAll()
                self.tblCourt.reloadData()
            }
        }
    }
}
