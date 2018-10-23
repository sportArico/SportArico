

import UIKit

class MarketTopCell: UICollectionViewCell {

    @IBOutlet weak var TopCollectionview: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var ArrayImageSlider:[MarketSliderData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        TopCollectionview.register(UINib(nibName: "MarketTopSliderCell", bundle: nil), forCellWithReuseIdentifier: "MarketTopSliderCell")
        self.APICallGetSlider()
    }

}

extension MarketTopCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArrayImageSlider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketTopSliderCell", for: indexPath) as! MarketTopSliderCell
        let obj = ArrayImageSlider[indexPath.row]
        cell.imgImage.sd_setImage(with: URL.init(string: obj.marketSliderImage!), completed: nil)
        cell.lblTitle.text = obj.marketSliderTitle
        cell.lblDes.text = obj.marketSliderText
        cell.btnCallNow.tag = indexPath.row
        cell.btnCallNow.addTarget(self, action: #selector(CallNow(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        return CGSize(width: Screenwidth, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            //self.pageControl.currentPage = indexPath.row
        self.pageControl.currentPage = Int(collectionView.contentOffset.x) / Int(collectionView.frame.width)
    }
    
    @objc func CallNow(_ sender:UIButton)  {
        let obj = ArrayImageSlider[sender.tag]
        obj.contactNumber?.makeAColl()
    }
    
}

//MARK: APICall...
extension MarketTopCell{
    func APICallGetSlider() {
        MarketManager.shared.GetMarketImageSlider { (ArrayMarketSliderData, error) in
            if error != ""{
                //Utility.setAlertWith(title: "Error", message: error, controller: self)
                return
            }
            else if ArrayMarketSliderData.count > 0{
                self.ArrayImageSlider = ArrayMarketSliderData as! [MarketSliderData]
                self.pageControl.numberOfPages = self.ArrayImageSlider.count
                self.TopCollectionview.delegate = self
                self.TopCollectionview.dataSource = self
                self.TopCollectionview.reloadData()
            }
            else{
                //Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
                return 
            }
        }
    }
}
