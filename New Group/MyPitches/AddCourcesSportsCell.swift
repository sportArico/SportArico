

import UIKit

class AddCourcesSportsCell: UITableViewCell {

    @IBOutlet weak var imgSportsImage: UIImageView!
    @IBOutlet weak var lblSportName: UILabel!
    @IBOutlet weak var btnFromTime: UIButton!
    @IBOutlet weak var btnToTime: UIButton!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var btnOffer: UIButton!
    @IBOutlet weak var txtPercentage: UITextField!
    @IBOutlet weak var btnOfferFrom: UIButton!
    @IBOutlet weak var btnOfferTo: UIButton!
    @IBOutlet weak var txtPakagePrice: UITextField!
    @IBOutlet weak var txtPakageName: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDesc: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        btnOffer.layer.cornerRadius = btnOffer.layer.frame.height / 2
        btnOffer.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
