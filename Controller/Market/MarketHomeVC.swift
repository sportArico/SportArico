

import UIKit
import KYDrawerController

class MarketHomeVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var collview: UICollectionView!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnFiltter: UIButton!
    @IBOutlet weak var lblLocationName: UILabel!
    //=== End === //
    
    
    //MARK: Variable
    var ArrayMarketProductList:MarketHomeProductData?
    //=== End === //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collview.register(UINib(nibName: "MarketTopCell", bundle: nil), forCellWithReuseIdentifier: "MarketTopCell")
        collview.register(UINib(nibName: "MarketRecommendedCell", bundle: nil), forCellWithReuseIdentifier: "MarketRecommendedCell")
        collview.register(UINib(nibName: "MarketHomeCell", bundle: nil), forCellWithReuseIdentifier: "MarketHomeCell")
        
//        collview.delegate = self
//        collview.dataSource = self
//        collview.reloadData()
        //
        self.APICallMarketProductList(UserId: (UserManager.shared.currentUser?.user_id)!)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblLocationName.text = AppDelegate.sharedDelegate().location_name
        NotificationCenter.default.addObserver(self, selector: #selector(self.CellSelection(_:)), name: NSNotification.Name(rawValue: "CellSelection"), object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "CellSelection"), object: nil)
    }
    // handle notification
    @objc func CellSelection(_ notification: NSNotification) {
        if let obj:MarketHomeRecommandProduct = notification.object as? MarketHomeRecommandProduct{
            let storyboard = UIStoryboard(name: "Market", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "MarketProductDetailVC") as! MarketProductDetailVC
            ivc.product_id = obj.mProductId!
            navigationController?.pushViewController(ivc, animated: true)
        }
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
    
    @IBAction func btnFiltter(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Market", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "MarketPreferenceVC") as! MarketPreferenceVC
        navigationController?.pushViewController(ivc, animated: true)
    }
    
    @IBAction func btnCart(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "ChangeCategoryVC") as! ChangeCategoryVC
        ivc.modalPresentationStyle = .overCurrentContext
        ivc.modalTransitionStyle = .coverVertical
        self.present(ivc, animated: true, completion: nil)
    }
    
    @IBAction func btnChangeLocation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "SearchLocationVC") as! SearchLocationVC
        ivc.OnSave = { (Param) in
            print(Param)
            //let param = ["sport_id":"","latitude":Param["latitude"]!,"longitude":Param["longitude"]!,"location":AppDelegate.sharedDelegate().location_name,"gender":"","distance":"","user_id":UserManager.shared.currentUser?.user_id]
            self.APICallMarketProductList(UserId: (UserManager.shared.currentUser?.user_id)!)
        }
        navigationController?.pushViewController(ivc, animated: true)
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        tabBarController?.selectedIndex = 2
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
extension MarketHomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else if section == 1{
            return 1
        }
        else if section == 2{
            return (self.ArrayMarketProductList?.productList?.count)!
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketTopCell", for: indexPath) as! MarketTopCell
            return cell
        }
        else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketRecommendedCell", for: indexPath) as! MarketRecommendedCell
            cell.ArrayRecommended = (self.ArrayMarketProductList?.recommandProduct)!
            return cell
        }
        else if indexPath.section == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketHomeCell", for: indexPath) as! MarketHomeCell
            let obj = self.ArrayMarketProductList?.productList![indexPath.row]
            cell.lblName.text = "AED \(obj?.productPrice ?? "")"
            cell.lblDes.text = obj?.productTitle
            let productImage = obj?.productImages
            if productImage!.count > 0{
                cell.imgProductImage.sd_setImage(with: URL.init(string: (obj?.productImages![0].image!)!), completed: nil)
            }
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1{
            
        }
        if indexPath.section == 2{
            let storyboard = UIStoryboard(name: "Market", bundle: nil)
            let ivc = storyboard.instantiateViewController(withIdentifier: "MarketProductDetailVC") as! MarketProductDetailVC
            let obj = self.ArrayMarketProductList?.productList![indexPath.row]
            ivc.product_id = (obj?.mProductId!)!
            navigationController?.pushViewController(ivc, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        if indexPath.section == 0{
            return CGSize(width: Screenwidth, height: 220)
        } else if indexPath.section == 1 {
            return CGSize(width: Screenwidth, height: 250)
        } else if indexPath.section == 2 {
            return CGSize(width: (Screenwidth - 45) / 2, height: 160)
        } else {
            return CGSize(width: 0, height: 0)
        }
        
    }
    
}

//MARK: API Calling...
extension MarketHomeVC{
    func APICallMarketProductList(UserId: String) {
        MarketManager.shared.GetMarketProduct(withID: UserId) { (ArrayMarketProduct, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayMarketProduct != nil{
                self.ArrayMarketProductList = ArrayMarketProduct
                self.collview.delegate = self
                self.collview.dataSource = self
                self.collview.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
            
        }
    }
}
