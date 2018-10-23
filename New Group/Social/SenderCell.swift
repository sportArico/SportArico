

import UIKit

class SenderCell: UITableViewCell {
    
    @IBOutlet weak var profilePic: RoundedImageView!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var messageBackground: UIImageView!
    @IBOutlet weak var lblTimeAgo: UILabel!
    
    func clearCellData()  {
        self.message.text = nil
        self.message.isHidden = false
        self.messageBackground.image = nil
        self.lblTimeAgo.text = ""
        self.lblTimeAgo.isHidden = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.message.textContainerInset = UIEdgeInsetsMake(5, 20, 5, 5)
        self.messageBackground.layer.cornerRadius = 5
        self.messageBackground.clipsToBounds = true
    }
}

class ReceiverCell: UITableViewCell {
    
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var messageBackground: UIImageView!
    
    func clearCellData()  {
        self.message.text = nil
        self.message.isHidden = false
        self.messageBackground.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.message.textContainerInset = UIEdgeInsetsMake(5, 5, 5, 5)
        self.messageBackground.layer.cornerRadius = 15
        self.messageBackground.clipsToBounds = true
    }
}

class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        let radius: CGFloat = self.bounds.size.width / 2.0
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

class UserGroupListCell: UITableViewCell {
    
    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMSG: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblTimeAgo: UILabel!
    @IBOutlet weak var lblIsOnline: UILabel!
    @IBOutlet weak var TimeWidth: NSLayoutConstraint!
    
    override func awakeFromNib(){
        super.awakeFromNib()
        imgUserImage.layer.cornerRadius = imgUserImage.layer.frame.height / 2
        imgUserImage.contentMode = .scaleAspectFill
        imgUserImage.clipsToBounds = true
        self.lblIsOnline.layer.cornerRadius = self.lblIsOnline.frame.height / 2
        self.lblIsOnline.layer.borderColor = UIColor.white.cgColor
        self.lblIsOnline.layer.borderWidth = 1
        self.lblIsOnline.clipsToBounds = true
    }
}
