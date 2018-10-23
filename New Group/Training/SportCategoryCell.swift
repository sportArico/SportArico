

import UIKit

class SportCategoryCell: UICollectionViewCell {

    @IBOutlet weak var imgSportImage: UIImageView!
    @IBOutlet weak var lblSportName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgSportImage.contentMode = .scaleAspectFill
        imgSportImage.layer.cornerRadius = imgSportImage.layer.frame.height / 2
        imgSportImage.layer.borderWidth = 1
        imgSportImage.layer.borderColor = UIColor.colorFromHex(hexString: "#0088FF").cgColor
        imgSportImage.clipsToBounds = true
    }

}
