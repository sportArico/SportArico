

import UIKit
import GoogleMaps

class SocialDetailVC: UIViewController {
    
    //MARK:Outlet
    @IBOutlet weak var lblVenue: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var btnMissingSlots: UIButton!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtDes: UITextView!
    @IBOutlet weak var MemberCollectionview: UICollectionView!
    @IBOutlet weak var mapView: GMSMapView!
    //=== End ===//
    
    //MARK: Variable
    var ArraySocialDetail:[SocialGroupDetailData] = []
    var Group_Id = ""
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MemberCollectionview.register(UINib(nibName: "SocialMemberStaticCell", bundle: nil), forCellWithReuseIdentifier: "SocialMemberStaticCell")
        
        self.APICallGetDetail(group_id: Group_Id)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnShare(_ sender: Any) {
        let message = "Try this app to "
        //if let link = NSURL(string: "https://itunes.apple.com/us/app/easyvent/id1401839200?ls=1&mt=8") {
        let objectsToShare = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        //navigationController?.present(activityVC, animated: true, completion: nil)
        // }
    }
    @IBAction func btnJoinTeam(_ sender: Any) {
        SocialManager.shared.JoinGroup(Group_id: self.Group_Id, user_id: (UserManager.shared.currentUser?.user_id)!) { (IsJoin, error) in
            if IsJoin == true{
                Utility.setAlertWith(title: "Success", message: error, controller: self)
            }
            else{
                 Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
    
    @IBAction func btnChatWithTeam(_ sender: Any) {
        let storybord = UIStoryboard(name: "Social", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "SocialGroupChatDetailVC") as! SocialGroupChatDetailVC
        VC.group_id = self.Group_Id
        if self.ArraySocialDetail.count > 0{
            VC.DetailData = self.ArraySocialDetail[0]
        }
        navigationController?.pushViewController(VC, animated: true)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func SetUIDetail(data: SocialGroupDetailData?) {
        lblVenue.text = "Venue: \(data?.venue ?? "")"
        lblLocation.text = "\(data?.location ?? "") (km)"
        lblDate.text = GetFormatedDate(From: "yyyy-MM-dd", To: "EEE,dd MMM", Value: (data?.eventDate)!)
        lblTime.text = data?.eventTime
        let max_member:Int = Int((data?.maxSize)!)!
        let member:Int = (data?.memberCount)!
        btnMissingSlots.setTitle("Missing \(max_member - member) slots!(\(data?.memberCount ?? 0)/\(data?.maxSize ?? ""))", for: .normal)
        lblPrice.text = "\(data?.price ?? "") AED Per Player"
        txtDes.text = data?.descriptionField
        
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(data?.latitude ?? "\(AppDelegate.sharedDelegate().userLatitude)") ?? 0.0, longitude: Double(data?.longitude ?? "\(AppDelegate.sharedDelegate().userLongitude)") ?? 0.0, zoom: 0)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(data?.latitude ?? "\(AppDelegate.sharedDelegate().userLatitude)") ?? 0.0, longitude: Double(data?.longitude ?? "\(AppDelegate.sharedDelegate().userLongitude)") ?? 0.0)
        mapView.camera = camera
        marker.map = mapView
        
        var bounds = GMSCoordinateBounds()
        bounds = bounds.includingCoordinate(marker.position)
        let update = GMSCameraUpdate.fit(bounds, withPadding: 60)
        mapView.animate(with: update)
        
    }
    
    
}
extension SocialDetailVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            return (self.ArraySocialDetail[0].memberList?.count)!
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMemberStaticCell", for: indexPath) as? SocialMemberStaticCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SocialMemberCell", for: indexPath) as? SocialMemberCell else {
                return UICollectionViewCell()
            }
            cell.lblName.text = self.ArraySocialDetail[0].memberList?[indexPath.row].fullName
            cell.imgMemberImage.layer.cornerRadius = cell.imgMemberImage.layer.frame.size.height / 2
            cell.clipsToBounds = true
            cell.imgMemberImage.sd_setImage(with: URL.init(string: (self.ArraySocialDetail[0].memberList?[indexPath.row].profileImage)!), completed: nil)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0{
            SocialManager.shared.JoinGroup(Group_id: self.Group_Id, user_id: (UserManager.shared.currentUser?.user_id)!) { (IsJoin, error) in
                if IsJoin == true{
                    Utility.setAlertWith(title: "Success", message: error, controller: self)
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            }
        }
        else{
            
        }
    }
    
    
}
extension SocialDetailVC{
    func APICallGetDetail(group_id: String) {
        SocialManager.shared.GetTrainingDetail(Group_id: group_id) { (ArraySocialGroupDetail, error) in
            if error != ""{
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else if ArraySocialGroupDetail.count > 0{
                self.ArraySocialDetail = ArraySocialGroupDetail as! [SocialGroupDetailData]
                self.SetUIDetail(data: ArraySocialGroupDetail[0])
                self.MemberCollectionview.delegate = self
                self.MemberCollectionview.dataSource = self
                self.MemberCollectionview.reloadData()
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "no data available", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
