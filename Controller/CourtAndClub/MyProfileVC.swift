
import UIKit

class MyProfileVC: UIViewController {

    //MARK: Outlte
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var imgUserImage: UIImageView!
    
    @IBOutlet weak var btnSetting: UIButton!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnUpgrade: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var MyInterstingAndMyGroupView: UIView!
    @IBOutlet weak var EditProfileView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtAbout: UITextView!
    //=== End ===//
    
    //MARK: Variable
    var UserProfileData:UserProfileData?
    var UserImage: UIImage?
    var picker = UIImagePickerController()
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imgUserImage.layer.cornerRadius = imgUserImage.frame.height / 2
        imgUserImage.clipsToBounds = true
        
        MyInterstingAndMyGroupView.isHidden = false
        EditProfileView.isHidden = true
        self.GetUserProfile(UserId: (UserManager.shared.currentUser?.user_id)!)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func txtGender(_ sender: Any) {
        self.view.endEditing(true)
        let alert = UIAlertController(title: "Select Gender", message: "", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Male", style: .default , handler:{ (UIAlertAction)in
            print("User click Edit button")
            self.txtGender.text = "male"
        }))
        
        alert.addAction(UIAlertAction(title: "FeMale", style: .default , handler:{ (UIAlertAction)in
            print("User click Delete button")
            self.txtGender.text = "female"
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnEdit(_ sender: Any) {
        MyInterstingAndMyGroupView.isHidden = true
        EditProfileView.isHidden = false
    }
    @IBAction func btnUpdate(_ sender: Any) {
        
        guard (txtName.text  == "" ? nil : txtName.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Name", controller: self)
            return
        }
        guard (txtMobile.text  == "" ? nil : txtMobile.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Phone Number", controller: self)
            return
        }
        guard (txtEmail.text  == "" ? nil : txtEmail.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Email-ID", controller: self)
            return
        }
        guard (validateEmail(email: txtEmail.text!) != nil ? txtEmail.text : nil) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Email-ID", controller: self)
            return
        }
        guard (txtGender.text  == "" ? nil : txtGender.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Select valid Gender", controller: self)
            return
        }
        
        self.APICallUpdateProfile(param: ["full_name":txtName.text!,"email":txtEmail.text!,"phone":txtMobile.text!,"about":txtAbout.text!,"gender":txtGender.text!,"user_id":(UserManager.shared.currentUser?.user_id)!], img: self.UserImage)
    }
    @IBAction func btnSetting(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
        present(VC, animated: true, completion: nil)
    }
    @IBAction func btnMessage(_ sender: Any) {
        
    }
    @IBAction func btnUpgrade(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "VendorUpgradeVC") as! VendorUpgradeVC
        ivc.modalPresentationStyle = .overCurrentContext
        ivc.modalTransitionStyle = .crossDissolve
        self.present(ivc, animated: true, completion: nil)
    }
    @IBAction func btnSelectProfileImage(_ sender: Any) {
        self.OpenAction()
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
extension MyProfileVC{
    
    func GetUserProfile(UserId: String) {
        UserManager.shared.GetUserProfile(withUserID: UserId) { (UserData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else{
                self.UserProfileData = UserData
                self.lblName.text = UserData?.basicInfo?.fullName
                self.txtName.text = UserData?.basicInfo?.fullName
                self.lblMobile.text = UserData?.phone
                self.txtEmail.text = UserData?.email
                self.txtMobile.text = UserData?.phone
                self.txtGender.text = UserData?.basicInfo?.gender
                if UserData?.basicInfo?.about != ""{
                    self.txtAbout.text = UserData?.basicInfo?.about
                }
                else{
                    self.txtAbout.placeholder = "About"
                }
                self.imgUserImage.sd_setImage(with: URL.init(string: (UserData?.basicInfo?.profileImage)!), placeholderImage: #imageLiteral(resourceName: "photo"), completed: nil)
            }
        }
    }
    
    func APICallUpdateProfile(param:[String:String],img: UIImage?) {
        UserManager.shared.UpdateProfile(withParametrs: param, avatar: img) { (isUpdated, userData,error) in
            if isUpdated == true{
                self.MyInterstingAndMyGroupView.isHidden = false
                self.EditProfileView.isHidden = true
                Utility.setAlertWith(title: "Success", message: error, controller: self)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}
//MARK: Image Picker
extension MyProfileVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func OpenAction() {
        let actionSheet = UIAlertController(title: "Choose For Image", message: "Please select option to add picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alertAction) in
            self.showCameraControl()
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (alertAction) in
            self.showPhotoLibrary()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (alertAction) in
            // Do Nothing
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func showCameraControl()  {
        let photoLibrary = UIImagePickerController()
        photoLibrary.sourceType = .camera
        photoLibrary.allowsEditing = true
        photoLibrary.delegate = self
        self.present(photoLibrary, animated: true, completion: nil)
    }
    func showPhotoLibrary() {
        let photoLibrary = UIImagePickerController()
        photoLibrary.sourceType = .photoLibrary
        photoLibrary.allowsEditing = true
        photoLibrary.delegate = self
        self.present(photoLibrary, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.UserImage = image
        self.imgUserImage.image = image
    }
}
