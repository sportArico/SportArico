

import UIKit
import Cosmos

class MarketProductDetailVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var collview: UICollectionView!
    @IBOutlet weak var imgCenterImage: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAED: UILabel!
    @IBOutlet weak var lblDes: UITextView!
    @IBOutlet weak var lblDesHeight: NSLayoutConstraint!
    @IBOutlet weak var MainScollHeight: NSLayoutConstraint!
    @IBOutlet weak var lblSKU: UILabel!
    @IBOutlet weak var btnCallNow: UIButton!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var StarView: CosmosView!
    //=== End ===
    
    //MARK: Variable
    var product_id = ""
    var MarketProductDetail:MarketProductDetailData?
    var ReletedProductList:[RelatedProductDetail] = []
    var productImage:[ProductImageDetail] = []
    //=== End===

    override func viewDidLoad() {
        super.viewDidLoad()

        imgCenterImage.contentMode = .scaleAspectFill
        imgCenterImage.clipsToBounds = true
        lblDesHeight.constant = 0
        collview.register(UINib(nibName: "MarketHomeCell", bundle: nil), forCellWithReuseIdentifier: "MarketHomeCell")
        
        self.APICallProductDetail(urlvalue: "\(product_id)/\(UserManager.shared.currentUser?.user_id ?? "")")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func btn1(_ sender: Any) {
        img1.layer.borderColor = UIColor.colorFromHex(hexString: "#007AFF").cgColor
        img2.layer.borderColor = UIColor.white.cgColor
        img3.layer.borderColor = UIColor.white.cgColor
        if productImage.count > 0{
            imgCenterImage.sd_setImage(with: URL.init(string: productImage[0].image!), completed: nil)
        }
    }
    @IBAction func btn2(_ sender: Any) {
        img1.layer.borderColor = UIColor.white.cgColor
        img2.layer.borderColor = UIColor.colorFromHex(hexString: "#007AFF").cgColor
        img3.layer.borderColor = UIColor.white.cgColor
        if productImage.count > 1{
            imgCenterImage.sd_setImage(with: URL.init(string: productImage[1].image!), completed: nil)
        }
    }
    @IBAction func btn3(_ sender: Any) {
        img1.layer.borderColor = UIColor.white.cgColor
        img2.layer.borderColor = UIColor.white.cgColor
        img3.layer.borderColor = UIColor.colorFromHex(hexString: "#007AFF").cgColor
        if productImage.count > 2{
            imgCenterImage.sd_setImage(with: URL.init(string: productImage[2].image!), completed: nil)
        }
    }
    @IBAction func btnCallNow(_ sender: Any) {
        self.MarketProductDetail?.providerNumber?.makeAColl()
    }
    @IBAction func btnFav(_ sender: Any) {
        self.AddToFav(userID: (UserManager.shared.currentUser?.user_id)!, Market_Product_Id: (self.MarketProductDetail?.mProductId)!)
    }
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
        MainScollHeight.constant += self.lblDes.contentSize.height - 100
    }
    
    @IBAction func btnMoreProduct(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Market", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "MarketProductListVC") as! MarketProductListVC
        ivc.MarketProductDetail = self.MarketProductDetail
        navigationController?.pushViewController(ivc, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func SetUI(data: MarketProductDetailData) {
        if productImage.count > 0{
            img1.sd_setImage(with: URL.init(string: productImage[0].image!), completed: nil)
            imgCenterImage.sd_setImage(with: URL.init(string: productImage[0].image!), completed: nil)
        }
        if productImage.count > 1{
            img2.sd_setImage(with: URL.init(string: productImage[1].image!), completed: nil)
        }
        if productImage.count > 2{
            img3.sd_setImage(with: URL.init(string: productImage[2].image!), completed: nil)
        }
        lblName.text = data.productTitle
        lblAED.text = "AED \(data.productPrice ?? "")"
        lblDes.text = data.productDescription
        lblSKU.text = "\(data.sku ?? "")"
        self.adjustUITextViewHeight(arg: lblDes)
        if data.isBookmark == 0{
            btnFav.setImage(#imageLiteral(resourceName: "heart_icon"), for: .normal)
        }
        else{
            btnFav.setImage(#imageLiteral(resourceName: "heart_icon_select"), for: .normal)
        }
        if data.rating == "No Rating"{
            //self.StarView.text = data.rating
        }else{
            self.StarView.rating = Double(data.rating ?? "0.0")!
        }
    }
}
extension MarketProductDetailVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ReletedProductList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketHomeCell", for: indexPath) as! MarketHomeCell
        let obj = self.ReletedProductList[indexPath.row]
        cell.lblName.text = obj.productTitle
        cell.lblDes.text = obj.productDescription
        let productImage = obj.productImages
        if productImage!.count > 0{
            cell.imgProductImage.sd_setImage(with: URL.init(string: productImage![0].image!), completed: nil)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        return CGSize(width: (Screenwidth - 45) / 2, height: 180)
    }
}

//MARK: API Calling...
extension MarketProductDetailVC{
    func APICallProductDetail(urlvalue: String) {
        MarketManager.shared.GetMarketProductDetail(withID: urlvalue) { (ProductDetail, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ProductDetail != nil{
                self.MarketProductDetail = ProductDetail
                self.ReletedProductList = (self.MarketProductDetail?.relatedProduct)!
                self.productImage = (self.MarketProductDetail?.productImages)!
                self.SetUI(data: self.MarketProductDetail!)
                self.collview.delegate = self
                self.collview.dataSource = self
                self.collview.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
        }
    }
    func AddToFav(userID: String,Market_Product_Id: String) {
        MarketManager.shared.AddToBookMark(withID: userID, Market_Product_Id: Market_Product_Id,IsFav: true) { (isAdded, error) in
            if isAdded == true{
                Utility.setAlertWith(title: "Succses", message: error, controller: self)
                if self.btnFav.currentImage == #imageLiteral(resourceName: "heart_icon"){
                    self.btnFav.setImage(#imageLiteral(resourceName: "heart_icon_select"), for: .normal)
                }
                else{
                    self.btnFav.setImage(#imageLiteral(resourceName: "heart_icon"), for: .normal)
                }
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}
