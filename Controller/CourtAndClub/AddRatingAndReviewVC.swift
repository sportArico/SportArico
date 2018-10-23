

import UIKit
import OpalImagePicker
import Photos
import Cosmos

class AddRatingAndReviewVC: UIViewController {

    
    //MARK:Outlet
    @IBOutlet weak var btnclose: UIButton!
    @IBOutlet weak var txtcomment: UITextView!
    @IBOutlet weak var btnAttachment: UIButton!
    @IBOutlet weak var imgAttach1: UIImageView!
    @IBOutlet weak var imgAttach2: UIImageView!
    @IBOutlet weak var imgAttach3: UIImageView!
    @IBOutlet weak var PlaceStarView: CosmosView!
    @IBOutlet weak var PlacePlacesView: CosmosView!
    @IBOutlet weak var PlaceRecommendView: CosmosView!
    //=== End ===//
    
    //MARK: Variable
    var OnBack: ((_ isBack: Bool) -> ())?
    var Court_ID = ""
    let imagePicker = OpalImagePickerController()
    var PlaceRating = Double()
    var ServiceRating = Double()
    var RecommendRating = Double()
    var img:[UIImage] = []
    var ReviewType = ""
    //=== End ===//
    
    
    fileprivate func SetUpImagePicker() {
        imagePicker.imagePickerDelegate = self
        //Change color of selection overlay to white
        imagePicker.selectionTintColor = UIColor.black.withAlphaComponent(0.7)
        
        //Change color of image tint to black
        imagePicker.selectionImageTintColor = UIColor.black
        
        //Change image to X rather than checkmark
        imagePicker.selectionImage = UIImage(named: "right_icon_Select")
        
        //Change status bar style
        imagePicker.statusBarPreference = UIStatusBarStyle.lightContent
        
        //Limit maximum allowed selections to 5
        imagePicker.maximumSelectionsAllowed = 3
        
        //Only allow image media type assets
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        
        //Change default localized strings displayed to the user
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = "You cannot select that many images!".localiz()
        imagePicker.configuration = configuration
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.colorFromHex(hexString: "#007AFF").withAlphaComponent(0.8)
        txtcomment.placeholder = "Write your comment..."
        SetUpImagePicker()
        PlaceStarView.didFinishTouchingCosmos = { rating in
            self.PlaceRating = rating
        }
        PlacePlacesView.didFinishTouchingCosmos = { rating in
            self.ServiceRating = rating
        }
        PlaceRecommendView.didFinishTouchingCosmos = { rating in
            self.RecommendRating = rating
        }
        imgAttach1.layer.cornerRadius = imgAttach1.frame.size.height / 2
        imgAttach1.layer.borderColor = UIColor.white.cgColor
        imgAttach1.borderWidth = 1.0
        imgAttach1.clipsToBounds = true
        imgAttach2.layer.cornerRadius = imgAttach2.frame.size.height / 2
        imgAttach2.layer.borderColor = UIColor.white.cgColor
        imgAttach2.borderWidth = 1.0
        imgAttach2.clipsToBounds = true
        imgAttach3.layer.cornerRadius = imgAttach3.frame.size.height / 2
        imgAttach3.layer.borderColor = UIColor.white.cgColor
        imgAttach3.borderWidth = 1.0
        imgAttach3.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnclose(_ sender: Any) {
        self.OnBack?(true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnAttachment(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        guard (txtcomment.text  == "" ? nil : txtcomment.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Comment", controller: self)
            return
        }
        var param:[String:String] = [:]
        if ReviewType == "court"{
            param = ["user_id":(UserManager.shared.currentUser?.user_id)!,"court_id":self.Court_ID,"service":"\(self.ServiceRating)","place":"\(self.PlaceRating)","recommend":"\(self.RecommendRating)","review":txtcomment.text!]
        }
        else if ReviewType == "cources"{
            param = ["user_id":(UserManager.shared.currentUser?.user_id)!,"course_id":self.Court_ID,"service":"\(self.ServiceRating)","place":"\(self.PlaceRating)","recommend":"\(self.RecommendRating)","review":txtcomment.text!]
        }
        if let img1 = imgAttach1.image{
            img.append(img1)
        }
        if let img2 = imgAttach2.image{
            img.append(img2)
        }
        if let img3 = imgAttach3.image{
            img.append(img3)
        }
        self.APICallAddRating(param: param, images: img, Type: self.ReviewType)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension AddRatingAndReviewVC{
    func APICallAddRating(param:[String:String],images:[UIImage?],Type:String) {
        CourtAndClubManager.shared.AddRating(parametrs: param, photo: images, Type: Type) { (IsAdded, error) in
            if IsAdded == true{
                let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.OnBack?(true)
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                self.img.removeAll()
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}
extension AddRatingAndReviewVC: OpalImagePickerControllerDelegate {
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        //Cancel action?
    }
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingImages images: [UIImage]) {
        //Save Images, update UI
        for i in 0..<images.count{
            if i == 0{
                self.imgAttach1.image = images[i]
            }
            else if i == 1{
                self.imgAttach2.image = images[i]
            }
            else if i == 2{
                self.imgAttach3.image = images[i]
            }
        }
        //Dismiss Controller
        //presentedViewController?.dismiss(animated: true, completion: nil)
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
//    func imagePickerNumberOfExternalItems(_ picker: OpalImagePickerController) -> Int {
//        return 1
//    }
    
//    func imagePickerTitleForExternalItems(_ picker: OpalImagePickerController) -> String {
//        return NSLocalizedString("External", comment: "External (title for UISegmentedControl)")
//    }
    
//    func imagePicker(_ picker: OpalImagePickerController, imageURLforExternalItemAtIndex index: Int) -> URL? {
//        return URL(string: "https://placeimg.com/500/500/nature")
//    }
}
