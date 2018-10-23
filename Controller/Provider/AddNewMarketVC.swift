

import UIKit

class AddNewMarketVC: UIViewController {

    
    //MARK: Outlet
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnISOfferNo: UIButton!
    @IBOutlet weak var btnISOfferYes: UIButton!
    @IBOutlet weak var OfferHeight: NSLayoutConstraint!
    @IBOutlet weak var OfferView: UIView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDes: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtSKU: UITextField!
    @IBOutlet weak var txtValidFrom: UITextField!
    @IBOutlet weak var txtValidTo: UITextField!
    @IBOutlet weak var txtDiscount: UITextField!
    @IBOutlet weak var btnAddOfferImage: UIButton!
    @IBOutlet weak var txtOfferDes: UITextField!
    @IBOutlet weak var txtTitle: UITextField!
    
    //=== End ===//
    
    
    //MARK: Variable
    var isActive = "1"
    var isOffer = "1"
    var datePicker : UIDatePicker!
    var isfromdate = false
    var picker = UIImagePickerController()
    var isSelectedImage = "0"
    var isEdit = false
    var M_Cat_ID = ""
    var M_Product_Id = ""
    var ProviderProductDetailData:ProviderProductDetailData?
    //=== End ===//
    
    fileprivate func SetUpUI() {
        btnNo.layer.cornerRadius = btnNo.layer.frame.width / 2
        btnNo.clipsToBounds = true
        btnYes.layer.cornerRadius = btnYes.layer.frame.width / 2
        btnYes.clipsToBounds = true
        btnISOfferNo.layer.cornerRadius = btnNo.layer.frame.width / 2
        btnISOfferNo.clipsToBounds = true
        btnISOfferYes.layer.cornerRadius = btnYes.layer.frame.width / 2
        btnISOfferYes.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        if isEdit{
            self.GetMarketProductDetail(user_id: (UserManager.shared.currentUser?.user_id)!, m_Product_id: self.M_Product_Id)
        }
        else{
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNo(_ sender: Any) {
        isActive = "0"
        btnNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
        btnYes.setImage(UIImage(named:""), for: .normal)
    }
    @IBAction func btnYes(_ sender: Any) {
        isActive = "1"
        btnNo.setImage(UIImage(named:""), for: .normal)
        btnYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
    }
    @IBAction func btnISOfferNo(_ sender: Any) {
        isOffer = "0"
        OfferView.isHidden = true
        OfferHeight.constant = 0
        btnISOfferNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
        btnISOfferYes.setImage(UIImage(named:""), for: .normal)
    }
    @IBAction func btnISOfferYes(_ sender: Any) {
        isOffer = "1"
        OfferView.isHidden = false
        OfferHeight.constant = 290
        btnISOfferNo.setImage(UIImage(named:""), for: .normal)
        btnISOfferYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
    }
    @IBAction func txtValidFrom(_ sender: Any) {
        self.isfromdate = true
        self.pickUpDate(txtValidFrom)
    }
    @IBAction func txtValidTo(_ sender: Any) {
        self.isfromdate = false
        self.pickUpDate(txtValidTo)
    }
    
    @IBAction func img1Select(_ sender: UITapGestureRecognizer) {
        if isEdit{
            if img1.image == #imageLiteral(resourceName: "square_blank_img"){
                self.isSelectedImage = "1"
                self.OpenAction()
            }
            else{
                //Delete image call...
                let alert = UIAlertController(title: "Alert", message: "Are you sure to delete this image", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: {(action:UIAlertAction!) in
                    for i in 0..<self.ProviderProductDetailData!.productImages!.count{
                        if i == 0{
                            ProviderManager.shared.DeleteProviderMarketProductImage(withID: self.ProviderProductDetailData!.productImages![i].marketProductMetaId!, completion: { (isDeleted, error) in
                                if isDeleted == true{
                                    let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                                        self.img1.image = #imageLiteral(resourceName: "square_blank_img")
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else{
                                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                                }
                            })
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            self.isSelectedImage = "1"
            self.OpenAction()
        }
    }
    @IBAction func img2Select(_ sender: UITapGestureRecognizer) {
        if isEdit{
            if img2.image == #imageLiteral(resourceName: "square_blank_img"){
                self.isSelectedImage = "2"
                self.OpenAction()
            }
            else{
                //Delete image call...
                let alert = UIAlertController(title: "Alert", message: "Are you sure to delete this image", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: {(action:UIAlertAction!) in
                    for i in 0..<self.ProviderProductDetailData!.productImages!.count{
                        if i == 1{
                            ProviderManager.shared.DeleteProviderMarketProductImage(withID: self.ProviderProductDetailData!.productImages![i].marketProductMetaId!, completion: { (isDeleted, error) in
                                if isDeleted == true{
                                    let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                                        self.img2.image = #imageLiteral(resourceName: "square_blank_img")
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else{
                                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                                }
                            })
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            self.isSelectedImage = "2"
            self.OpenAction()
        }
    }
    @IBAction func img3Select(_ sender: UITapGestureRecognizer) {
        if isEdit{
            if img3.image == #imageLiteral(resourceName: "square_blank_img"){
                self.isSelectedImage = "3"
                self.OpenAction()
            }
            else{
                //Delete image call...
                let alert = UIAlertController(title: "Alert", message: "Are you sure to delete this image", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: {(action:UIAlertAction!) in
                    for i in 0..<self.ProviderProductDetailData!.productImages!.count{
                        if i == 2{
                            ProviderManager.shared.DeleteProviderMarketProductImage(withID: self.ProviderProductDetailData!.productImages![i].marketProductMetaId!, completion: { (isDeleted, error) in
                                if isDeleted == true{
                                    let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                                        self.img3.image = #imageLiteral(resourceName: "square_blank_img")
                                    }))
                                    self.present(alert, animated: true, completion: nil)
                                }
                                else{
                                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                                }
                            })
                        }
                    }
                }))
                alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            self.isSelectedImage = "3"
            self.OpenAction()
        }
    }
   
    @IBAction func btnAddCoverImage(_ sender: Any) {
        self.isSelectedImage = "4"
        self.OpenAction()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        guard (txtName.text  == "" ? nil : txtName.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Name", controller: self)
            return
        }
        guard (txtDes.text  == "" ? nil : txtDes.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Description", controller: self)
            return
        }
        guard (txtPrice.text  == "" ? nil : txtPrice.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Price", controller: self)
            return
        }
        guard (txtSKU.text  == "" ? nil : txtSKU.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid SKU", controller: self)
            return
        }
        if isOffer == "1"{
            guard (txtValidFrom.text  == "" ? nil : txtValidFrom.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter valid Date", controller: self)
                return
            }
            guard (txtValidTo.text  == "" ? nil : txtValidTo.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter valid Date", controller: self)
                return
            }
            guard (txtDiscount.text  == "" ? nil : txtDiscount.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter valid Discount", controller: self)
                return
            }
            guard (txtTitle.text  == "" ? nil : txtTitle.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter valid Offer Title", controller: self)
                return
            }
            
            guard (txtOfferDes.text  == "" ? nil : txtOfferDes.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter valid Offer Description", controller: self)
                return
            }
        }
        if self.isEdit{
            let param = ["user_id":UserManager.shared.currentUser?.user_id,"product_title":txtName.text!,"product_description":txtDes.text!,"product_price":txtPrice.text!,"m_cat_id":self.M_Cat_ID,"sku":txtSKU.text!,"is_active":self.isActive,"is_offer":self.isOffer,"valid_from":txtValidFrom.text!,"valid_to":txtValidTo.text!,"discount":txtDiscount.text!,"description":txtOfferDes.text!,"m_product_id":self.M_Product_Id,"offer_title":txtTitle.text!,"offer_description":txtOfferDes.text!]
            var imagse:[UIImage] = []
            let offerImage:[UIImage] = []
            imagse.append(img1.image!)
            imagse.append(img2.image!)
            imagse.append(img3.image!)
            self.APICallAddNewMarket(param: param as! [String : String], imags: imagse, offerImage: offerImage, c_Image: btnAddOfferImage.currentImage, IsEdit: true)
        }
        else{
            let param = ["user_id":UserManager.shared.currentUser?.user_id,"product_title":txtName.text!,"product_description":txtDes.text!,"product_price":txtPrice.text!,"m_cat_id":self.M_Cat_ID,"sku":txtSKU.text!,"is_active":self.isActive,"is_offer":self.isOffer,"valid_from":txtValidFrom.text!,"valid_to":txtValidTo.text!,"discount":txtDiscount.text!,"description":txtOfferDes.text!,"offer_title":txtTitle.text!,"offer_description":txtOfferDes.text!]
            var imagse:[UIImage] = []
            let offerImage:[UIImage] = []
            imagse.append(img1.image!)
            imagse.append(img2.image!)
            imagse.append(img3.image!)
            self.APICallAddNewMarket(param: param as! [String : String], imags: imagse, offerImage: offerImage, c_Image: btnAddOfferImage.currentImage, IsEdit: false)
        }
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
extension AddNewMarketVC{
    func APICallAddNewMarket(param: [String:String],imags: [UIImage?],offerImage: [UIImage?],c_Image: UIImage?,IsEdit: Bool) {
        ProviderManager.shared.AddNewPitches(withParametrs: param, photo: imags, offerImages: offerImage, videoPath: nil, coverImage: c_Image, iconImage: nil,UploadType: "Market",isEdit: IsEdit) { (isAdded, error) in
            if isAdded == true{
                let alert = UIAlertController(title: "Success", message: "Product Added Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                   self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
    
    func GetMarketProductDetail(user_id: String,m_Product_id: String){
        ProviderManager.shared.GetMarketProductDetail(withID: user_id, M_Product_Id: m_Product_id) { (ProviderData, error) in
            if ProviderData != nil{
                self.ProviderProductDetailData = ProviderData
                self.txtName.text = ProviderData?.productTitle
                self.txtDes.text = ProviderData?.productDescription
                self.isActive = (ProviderData?.isActive)!
                if self.isActive == "1"{
                    self.btnNo.setImage(UIImage(named:""), for: .normal)
                    self.btnYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
                }
                else{
                    self.btnNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
                    self.btnYes.setImage(UIImage(named:""), for: .normal)
                }
                self.txtPrice.text = ProviderData?.productPrice
                self.txtSKU.text = ProviderData?.sku
                self.isOffer = "\(ProviderData?.isOffer ?? 0)"
                if self.isOffer == "1"{
                    self.OfferView.isHidden = false
                    self.OfferHeight.constant = 250
                    self.btnISOfferNo.setImage(UIImage(named:""), for: .normal)
                    self.btnISOfferYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
                    self.txtValidFrom.text = ProviderData?.offerData?.validFrom
                    self.txtValidTo.text = ProviderData?.offerData?.validTo
                    self.txtDiscount.text = ProviderData?.offerData?.discount
                    self.txtDes.text = ProviderData?.offerData?.descriptionField
                    self.btnAddOfferImage.sd_setImage(with: URL.init(string: ProviderData?.offerData?.image ?? ""), for: .normal, completed: nil)
                    self.txtOfferDes.text = ProviderData?.offerData?.descriptionField
                }
                else{
                    self.OfferView.isHidden = true
                    self.OfferHeight.constant = 0
                    self.btnISOfferNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
                    self.btnISOfferYes.setImage(UIImage(named:""), for: .normal)
                }
                self.img1.image = #imageLiteral(resourceName: "square_blank_img")
                self.img2.image = #imageLiteral(resourceName: "square_blank_img")
                self.img3.image = #imageLiteral(resourceName: "square_blank_img")
                for i in 0..<ProviderData!.productImages!.count{
                    if i == 0{
                        self.img1.sd_setImage(with: URL.init(string: (ProviderData?.productImages![i].image)!), completed: nil)
                    }
                    else if i == 1{
                        self.img2.sd_setImage(with: URL.init(string: (ProviderData?.productImages![i].image)!), completed: nil)
                    }
                    else if i == 2{
                        self.img3.sd_setImage(with: URL.init(string: (ProviderData?.productImages![i].image)!), completed: nil)
                    }
                }
            }
            else{
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
            }
        }
    }
    func UploadSingleImage(img:[UIImage]) {
        ProviderManager.shared.UploadProviderMarketImage(product_id: self.M_Product_Id, photo: img, completion: { (isImageAdded, error) in
            if isImageAdded == true{
                let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.GetMarketProductDetail(user_id: (UserManager.shared.currentUser?.user_id)!, m_Product_id: self.M_Product_Id)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        })
    }
}
//MARK: DatePicker method
extension AddNewMarketVC{
    func pickUpDate(_ textField : UITextField){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddNewMarketVC.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddNewMarketVC.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "yyyy-MM-dd"
        if isfromdate{
            txtValidFrom.text = dateFormatter1.string(from: datePicker.date)
        }
        else{
            txtValidTo.text = dateFormatter1.string(from: datePicker.date)
        }
        txtValidFrom.resignFirstResponder()
        txtValidTo.resignFirstResponder()
    }
    @objc func cancelClick() {
        txtValidFrom.resignFirstResponder()
        txtValidTo.resignFirstResponder()
    }
}
//MARK: Image Picker
extension AddNewMarketVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
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
        if self.isSelectedImage == "1"{
            if self.isEdit{
                self.UploadSingleImage(img: [image])
            }
            else{
                self.img1.image = image
            }
        }
        else if self.isSelectedImage == "2"{
            if self.isEdit{
                self.UploadSingleImage(img: [image])
            }
            else{
                self.img2.image = image
            }
        }
        else if self.isSelectedImage == "3"{
            if self.isEdit{
                self.UploadSingleImage(img: [image])
            }
            else{
                self.img3.image = image
            }
        }
        else if self.isSelectedImage == "4"{
            self.btnAddOfferImage.setImage(image, for: .normal)
        }
    }
}
