

import UIKit

class CourcesCell: UITableViewCell {

    @IBOutlet weak var lblRecommendedLine: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgRightArrow: UIImageView!
    @IBOutlet weak var SportCollectionview: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgImage.contentMode = .scaleAspectFill
        imgImage.layer.cornerRadius = imgImage.layer.frame.height / 2
        imgImage.clipsToBounds = true
        SportCollectionview.register(UINib(nibName: "SportCategoryCell", bundle: nil), forCellWithReuseIdentifier: "SportCategoryCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
