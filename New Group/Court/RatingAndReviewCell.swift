

import UIKit

class RatingAndReviewCell: UITableViewCell {

    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    @IBOutlet weak var lblRatingCount: UILabel!
    @IBOutlet weak var lblRatingMSG: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgUserImage.layer.cornerRadius = imgUserImage.frame.size.height / 2
        imgUserImage.contentMode = .scaleAspectFill
        imgUserImage.clipsToBounds = true
        img1.contentMode = .scaleAspectFill
        img1.clipsToBounds = true
        img2.contentMode = .scaleAspectFill
        img2.clipsToBounds = true
        img3.contentMode = .scaleAspectFill
        img3.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
