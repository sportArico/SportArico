

import UIKit
import Cosmos

class CourtCell: UITableViewCell {
    
    @IBOutlet weak var imgBGImage: UIImageView!
    @IBOutlet weak var isRecommendedView: UIView!
    @IBOutlet weak var lblCourtName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var AddimageView: UIView!
    @IBOutlet weak var PriceWidth: NSLayoutConstraint!
    @IBOutlet weak var StarView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgBGImage.contentMode = .scaleAspectFill
        imgBGImage.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
