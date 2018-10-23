
import UIKit

class MarketRecommendedCell: UICollectionViewCell {

    @IBOutlet weak var RecommendedCollectionview: UICollectionView!
    var ArrayRecommended:[MarketHomeRecommandProduct] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        RecommendedCollectionview.register(UINib(nibName: "MarketHomeCell", bundle: nil), forCellWithReuseIdentifier: "MarketHomeCell")
        RecommendedCollectionview.delegate = self
        RecommendedCollectionview.dataSource = self
        RecommendedCollectionview.reloadData()
    }

}
extension MarketRecommendedCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ArrayRecommended.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarketHomeCell", for: indexPath) as! MarketHomeCell
        cell.lblName.text = "AED \(self.ArrayRecommended[indexPath.row].productPrice ?? "")"
        cell.lblDes.text = self.ArrayRecommended[indexPath.row].productTitle
        let productImage = self.ArrayRecommended[indexPath.row].productImages
        if productImage!.count > 0{
            cell.imgProductImage.sd_setImage(with: URL.init(string: (self.ArrayRecommended[indexPath.row].productImages![0].image!)), completed: nil)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        return CGSize(width: (Screenwidth - 45) / 2, height: 180)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.ArrayRecommended[indexPath.row]
        NotificationCenter.default.post(name: NSNotification.Name("CellSelection"), object: obj)
    }
}
