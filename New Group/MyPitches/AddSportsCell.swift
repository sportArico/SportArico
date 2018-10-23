

import UIKit

class AddSportsCell: UITableViewCell {

    @IBOutlet weak var imgSportsImage: UIImageView!
    @IBOutlet weak var lblSportName: UILabel!
    @IBOutlet weak var btnFromTime: UIButton!
    @IBOutlet weak var btnToTime: UIButton!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var selectOfferSwitch: UISwitch!
    @IBOutlet weak var txtPercentage: UITextField!
    @IBOutlet weak var btnOfferFrom: UIButton!
    @IBOutlet weak var btnOfferTo: UIButton!
    @IBOutlet weak var imgOfferImage: UIImageView!
    @IBOutlet weak var btnAddOfferImage: UIButton!
    @IBOutlet weak var lblUploadBannerImage: UILabel!
    @IBOutlet weak var txtValidFrom: UITextField!
    @IBOutlet weak var txtValidTo: UITextField!
    @IBOutlet weak var imgPicFrame: UIImageView!
    @IBOutlet weak var txtOfferTitle: UITextField!
    @IBOutlet weak var txtOfferDescription: UITextField!
    
    
    
    @IBOutlet weak var bgViewHeightConstraint: NSLayoutConstraint!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectOfferSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
