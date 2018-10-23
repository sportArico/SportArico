

import UIKit
import ImageSlideshow
import XLPagerTabStrip
import Cosmos

class OverViewVC: UIViewController,IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = IndicatorInfo(title: "OverView")
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    //MARK: Outlet
    @IBOutlet weak var SlideShow: ImageSlideshow!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDistanceAndLocation: UILabel!
    @IBOutlet weak var facilitycollectionview: UICollectionView!
    @IBOutlet weak var ShowStarView: CosmosView!
    //=== End ===//
    
    //MARK: Variable
    var Court_Id = ""
    var CourtDetailData:CourtDetailData?
    var ArraySliderImage:[UIImage] = []
    //=== End ===//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.APICallDetailGet(CourtId: self.Court_Id, lat: AppDelegate.sharedDelegate().userLatitude, long: AppDelegate.sharedDelegate().userLongitude)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBookNow(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BookNowVC") as! BookNowVC
        vc.CourtDetailData = CourtDetailData
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnNavigate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavigateVC") as! NavigateVC
        vc.CourtDetailData = self.CourtDetailData
        vc.MapType = "court"
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnBookMark(_ sender: Any) {
        CourtAndClubManager.shared.AddToBookMarkCourt(CourtId: self.Court_Id, user_id: (UserManager.shared.currentUser?.user_id)!) { (IsBookmark, error) in
            if IsBookmark == true{
                Utility.setAlertWith(title: "Success", message: error, controller: self)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
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
    // MARK: - Slideshow
    func initSlideShow()
    {
        var localSource:[ImageSource] = []
        
        for image in self.ArraySliderImage{
            localSource.append(ImageSource(image: image))
        }
        SlideShow.backgroundColor = UIColor.white
        SlideShow.slideshowInterval = 5.0
        SlideShow.pageControlPosition = PageControlPosition.insideScrollView
        //        slideshow.pageControlPosition = PageControlPosition.custom(padding: 30.0)
        SlideShow.pageControl.currentPageIndicatorTintColor = UIColor.black
        SlideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        SlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        SlideShow.activityIndicator = DefaultActivityIndicator()
        SlideShow.setImageInputs(localSource)
    }
    func SetUpUI(data: CourtDetailData?) {
        lblName.text = data?.courtTitle
        lblPrice.text = "AED \(data?.price ?? "")"
        lblDistanceAndLocation.text = "  \u{25CF} \(Double(data?.distance ?? "")?.rounded() ?? 0.0)km from you   \u{25CF} \(data?.location ?? "")"
        self.ShowStarView.rating = Double(data?.rating ?? 0)
        if data!.facilities!.count > 0{
            self.facilitycollectionview.delegate = self
            self.facilitycollectionview.dataSource = self
            self.facilitycollectionview.reloadData()
        }
        for item in (data?.images)!{
            DispatchQueue.global(qos: .background).async {
                do
                {
                    let data = try Data.init(contentsOf: URL.init(string: item.image!)!)
                    DispatchQueue.main.async {
                        if let image: UIImage = UIImage(data: data){
                            self.ArraySliderImage.append(image)
                            self.initSlideShow()
                        }
                    }
                }
                catch {
                    // error
                }
            }
        }
    }
    
}
//MARK: API Calling...
extension OverViewVC{
    func APICallDetailGet(CourtId: String, lat: String, long: String) {
        CourtAndClubManager.shared.GetCourtDetail(CourtId: CourtId, lat: lat, long: long) { (CourtDetailData, error) in
            if CourtDetailData != nil{
                self.CourtDetailData = CourtDetailData
                self.SetUpUI(data: CourtDetailData)
            }
            else{
                if error != ""{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                    let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
                }
            }
        }
    }
}
extension OverViewVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.CourtDetailData?.facilities?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityCollectionviewCell", for: indexPath) as? FacilityCollectionviewCell else {
            return UICollectionViewCell()
        }
        cell.imgFacilityImage.sd_setImage(with: URL.init(string: (self.CourtDetailData?.facilities![indexPath.row].facilityIcon)!), completed: nil)
        return cell
    }
    
    
}
