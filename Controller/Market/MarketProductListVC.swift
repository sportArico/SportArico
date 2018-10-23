
import UIKit

class MarketProductListVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var collview: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    //=== End ===
    
    //MARK: Variable
    var MarketProductDetail:MarketProductDetailData?
    var ArrayMoreProduct:[MarketHomeProductList] = []
    //=== End ===
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collview.register(UINib(nibName: "MarketHomeCell", bundle: nil), forCellWithReuseIdentifier: "MarketHomeCell")
        self.APICallMarketMoreProductList(VendorID: (MarketProductDetail?.vender)!)
        self.lblTitle.text = MarketProductDetail?.productTitle
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCallNow(_ sender: Any) {
        self.MarketProductDetail?.providerNumber?.makeAColl()
    }
    @IBAction func btnFav(_ sender: Any) {
        self.AddToBookMark(userID: (UserManager.shared.currentUser?.user_id)!, Market_Product_Id: (self.MarketProductDetail?.mProductId)!)
    }
    @IBAction func btnNavigate(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavigateVC") as! NavigateVC
        vc.MapType = "market"
        vc.MarketProductDetail = self.MarketProductDetail
        navigationController?.pushViewController(vc, animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MarketProductListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.ArrayMoreProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketHomeCell", for: indexPath) as! MarketHomeCell
        let obj = self.ArrayMoreProduct[indexPath.row]
        cell.lblName.text = "AED \(obj.productPrice ?? "")"
        cell.lblDes.text = obj.productTitle
        let productImage = obj.productImages
        if productImage!.count > 0{
            cell.imgProductImage.sd_setImage(with: URL.init(string: (obj.productImages![0].image!)), completed: nil)
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Market", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "MarketProductDetailVC") as! MarketProductDetailVC
        ivc.product_id = self.ArrayMoreProduct[indexPath.row].mProductId!
        navigationController?.pushViewController(ivc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        return CGSize(width: (Screenwidth - 45) / 2, height: 180)
    }
}

//MARK: API Calling...
extension MarketProductListVC{
    func APICallMarketMoreProductList(VendorID: String) {
        MarketManager.shared.GetMarketMoreProductList(withID: VendorID) { (ArrayMoreProductData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayMoreProductData.count > 0{
                self.ArrayMoreProduct = ArrayMoreProductData as! [MarketHomeProductList]
                self.collview.delegate = self
                self.collview.dataSource = self
                self.collview.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
        }
    }
    func AddToBookMark(userID: String,Market_Product_Id: String) {
        MarketManager.shared.AddToBookMark(withID: userID, Market_Product_Id: Market_Product_Id) { (isAdded, error) in
            if isAdded == true{
                Utility.setAlertWith(title: "Succses", message: error, controller: self)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}

