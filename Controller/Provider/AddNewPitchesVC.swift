

import UIKit
import CoreLocation
import RMPickerViewController

class AddNewPitchesVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtDes: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    
    
    @IBOutlet weak var OnlineBookingSwitch: UISwitch!
    @IBOutlet weak var facilitycollectionview: UICollectionView!
    @IBOutlet weak var tblAddSport: UITableView!
    @IBOutlet weak var tblSportsHeight: NSLayoutConstraint!
    //=== End ===//
    
    
    //MARK: Variable
    var OnlineBooking = "1"
    var ArrayFacility:[FacilityData] = []
    var ArraySportCategory:[SportCategoryData] = []
    var TempArraySportCategory:[SportCategoryData] = []
    var datePicker : UIDatePicker!
    var picker = UIImagePickerController()
    var isSelectedImage = "0"
    var isEdit = false
    var CourtID = ""
    var ArrayCourtDetail:[ProviderDetailData] = []
    var imagse:[UIImage] = []
    var offerImages:[UIImage] = []
    var OnSaveImage: ((_ Image: UIImage?) -> ())?
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OnlineBookingSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        self.tblAddSport.register(UINib(nibName: "AddSportsCell", bundle: nil), forCellReuseIdentifier: "AddSportsCell")
        
        if isEdit{
            self.APICallGetCourtDetail(Court_ID: self.CourtID)
        }
        else{
            txtLocation.text = AppDelegate.sharedDelegate().location_name
            self.APICallGetFacilityList()
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
    
    @IBAction func OnlineBookingSwitch(_ sender: Any) {
        if OnlineBookingSwitch.isOn == true {
            print("On")
            self.OnlineBooking = "1"
        }
        else {
            print("Off")
            self.OnlineBooking = "0"
        }
    }
    
    
    @IBAction func imgSelectLocation(_ sender: UITapGestureRecognizer) {
        self.GetLocationAndAPICall()
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
                    for i in 0..<self.ArrayCourtDetail[0].images!.count{
                        if i == 0{
                            ProviderManager.shared.DeleteProviderCourtImage(Court_Id: self.CourtID, ImageName: self.ArrayCourtDetail[0].images![i].imageName!, completion: { (isDeleted, error) in
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
                    for i in 0..<self.ArrayCourtDetail[0].images!.count{
                        if i == 1{
                            ProviderManager.shared.DeleteProviderCourtImage(Court_Id: self.CourtID, ImageName: self.ArrayCourtDetail[0].images![i].imageName!, completion: { (isDeleted, error) in
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
                    for i in 0..<self.ArrayCourtDetail[0].images!.count{
                        if i == 2{
                            ProviderManager.shared.DeleteProviderCourtImage(Court_Id: self.CourtID, ImageName: self.ArrayCourtDetail[0].images![i].imageName!, completion: { (isDeleted, error) in
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
    @IBAction func coverImage(_ sender: UITapGestureRecognizer) {
        if isEdit{
            
        }
        else{
            self.isSelectedImage = "4"
            self.OpenAction()
        }
        
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        if img1.image == #imageLiteral(resourceName: "square_blank_img") && img2.image == #imageLiteral(resourceName: "square_blank_img") && img3.image == #imageLiteral(resourceName: "square_blank_img"){
            Utility.setAlertWith(title: "Alert", message: "Please Upload one image to continue.", controller: self)
            return
        }
        
        guard (txtName.text  == "" ? nil : txtName.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Name", controller: self)
            return
        }
        guard (txtLocation.text  == "" ? nil : txtLocation.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Location", controller: self)
            return
        }
        guard (txtPrice.text  == "" ? nil : txtPrice.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Price", controller: self)
            return
        }
        guard (txtDes.text  == "" ? nil : txtDes.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Description", controller: self)
            return
        }
        
        var customeArray:[CustomeProviderModelRoot] = []
        var TimeFrom = ""
        var TimeTo = ""
        var discount = ""
        var offerFrom = ""
        var offerTo = ""
        var offertitle = ""
        var offerdesc = ""
        var cellHourlyPrice = ""
        for i in 0..<self.ArraySportCategory.count{
            let indexPath = IndexPath(row: i, section: 0)
            guard let cell = tblAddSport.cellForRow(at: indexPath) as? AddSportsCell else{
                return
            }
            
            if let offerFromdata = cell.btnFromTime.currentTitle, !offerFromdata.isEmpty,offerFromdata != "From"{
                TimeFrom = offerFromdata
            }
            else
            {
                Utility.setAlertWith(title: "Alert", message: "Please Enter From Time", controller: self)
                return
            }
            if let offerTodata = cell.btnToTime.currentTitle, !offerTodata.isEmpty,offerTodata != "To"{
                TimeTo = offerTodata
            }
            else
            {
                Utility.setAlertWith(title: "Alert", message: "Please Enter To Time", controller: self)
                return
            }
            
           
            if let price = cell.txtPrice.text, !price.isEmpty{
                cellHourlyPrice = price
            }
            else
            {
                Utility.setAlertWith(title: "Alert", message: "Please Hourly Price", controller: self)
                return
            }
            
            
            
            
            if self.ArraySportCategory[i].is_offer == 1{
                if let discountdata = cell.txtPercentage.text, !discountdata.isEmpty {
                    discount = discountdata
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Discount", controller: self)
                    return
                }
                
                
                if let valid = cell.txtValidFrom.text, !valid.isEmpty{
                    offerFrom = valid
                }
                else
                {
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer Valid From.", controller: self)
                    return
                }
                
                if let to = cell.txtValidTo.text, !to.isEmpty{
                    offerTo = to
                }
                else
                {
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer Valid To.", controller: self)
                    return
                }
                
                
                if let oTitle = cell.txtOfferTitle.text, !oTitle.isEmpty{
                    offertitle = oTitle
                }
                else
                {
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer Title.", controller: self)
                    return
                }
                
                if let oDesc = cell.txtOfferDescription.text, !oDesc.isEmpty{
                    offerdesc = oDesc
                }
                else
                {
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer Description.", controller: self)
                    return
                }
                
                
            
                if let offerimage = cell.imgOfferImage.image{
                    self.offerImages.append(offerimage)
                }
                else{
                    self.offerImages.removeAll()
                    Utility.setAlertWith(title: "Alert", message: "Please Upload All Offer Image", controller: self)
                    return
                }
            }
            let availabletimeobj:[CustomeProviderModelAvailableDatetime] = [CustomeProviderModelAvailableDatetime(availableDate: TimeFrom, availableTime: TimeTo)]
            
            
            let obj:CustomeProviderModelRoot = CustomeProviderModelRoot(availableDatetime: availabletimeobj, discount: discount, is_offer: self.ArraySportCategory[i].is_offer ?? 0, sport_id: Int(self.ArraySportCategory[i].sportId!) ?? 0, valid_from: offerFrom, valid_to: offerTo,offer_title:offertitle,offer_description:offerdesc)
            
            
            
            customeArray.append(obj)
        }
        var SportAvailableString:String
        do{
            let jsonData = try JSONEncoder().encode(customeArray)
            let jsonBatch1:String = String(data: jsonData, encoding: .utf8)!
            SportAvailableString = jsonBatch1
        }
        catch (let error) {
            print(error.localizedDescription)
            self.offerImages.removeAll()
            return
        }
        
        imagse.append(img1.image!)
        imagse.append(img2.image!)
        imagse.append(img3.image!)
        
        //offerImages.append(imgcoverImage.image!)
        var facility:[String] = []
        for item in self.ArrayFacility{
            //if item.isSelected{
                facility.append(item.facilityId!)
            //}
        }
        let stringfacility = facility.joined(separator: ",")
        var SportArray:[String] = []
        for item in self.ArraySportCategory{
            SportArray.append(item.sportId!)
        }
        let stringSport = SportArray.joined(separator: ",")
        if isEdit{
            let param = ["user_id":UserManager.shared.currentUser?.user_id,"court_title":txtName.text!,"latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"price":txtPrice.text!,"facilities":stringfacility,"sport_id":stringSport,"location":txtLocation.text!,"description":txtDes.text!,"sport_available":SportAvailableString,"booking_online":self.OnlineBooking,"court_id":self.CourtID,"offer_upload_ids":""]
            ProviderManager.shared.EditPitches(withParametrs: param as? [String : String], UploadType: "Court", completion: { (isUpdated, error) in
                if self.isEdit && isUpdated{
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            })
        }
        else{
            let param = ["user_id":UserManager.shared.currentUser?.user_id,"court_title":txtName.text!,"latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"price":txtPrice.text!,"facilities":stringfacility,"sport_id":stringSport,"location":txtLocation.text!,"description":txtDes.text!,"sport_available":SportAvailableString,"booking_online":self.OnlineBooking]
            self.APICallAddNewCourt(param: param as! [String : String], imags: imagse, offerImages: offerImages, c_Image: nil, iconImage: nil, isEdit: false)
        }
    }
    @IBAction func btnAddSport(_ sender: Any) {
        if self.TempArraySportCategory.count > 0{
            self.openPickerViewController()
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "no sport available.", controller: self)
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

extension AddNewPitchesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArraySportCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddSportsCell", for: indexPath) as? AddSportsCell else {
            return UITableViewCell()
        }
        cell.lblSportName.text = self.ArraySportCategory[indexPath.row].sportName
        //cell.imgSportsImage.sd_setImage(with: URL.init(string: self.ArraySportCategory[indexPath.row].sportIcon!), completed: nil)
        cell.btnFromTime.tag = indexPath.row
        cell.btnFromTime.addTarget(self, action: #selector(AddNewPitchesVC.btnFromDate(sender:)), for: .touchUpInside)
        
        cell.btnToTime.tag = indexPath.row
        cell.btnToTime.addTarget(self, action: #selector(AddNewPitchesVC.btnToTime(sender:)), for: .touchUpInside)
        
        cell.btnOfferFrom.tag = indexPath.row
        cell.btnOfferFrom.addTarget(self, action: #selector(AddNewPitchesVC.btnOfferFrom(sender:)), for: .touchUpInside)
        cell.btnOfferTo.tag = indexPath.row
        cell.btnOfferTo.addTarget(self, action: #selector(AddNewPitchesVC.btnOfferTo(sender:)), for: .touchUpInside)
        cell.selectOfferSwitch.tag = indexPath.row
        //cell.btnOffer.addTarget(self, action: #selector(AddNewPitchesVC.btnISOfferSelect(sender:)), for: .touchUpInside)
        cell.selectOfferSwitch.addTarget(self, action: #selector(AddNewPitchesVC.btnISOfferSelect(uiSwitch:)), for: UIControlEvents.valueChanged)
        if self.ArraySportCategory[indexPath.row].is_offer == 0{
            cell.btnOfferFrom.isHidden = true
            cell.btnOfferTo.isHidden = true
            cell.txtPercentage.isHidden = true
            //cell.btnOffer.setImage(UIImage(named: ""), for: .normal)
            cell.lblUploadBannerImage.isHidden = true
            cell.btnAddOfferImage.isHidden = true
            cell.txtValidTo.isHidden = true
            cell.txtValidFrom.isHidden = true
            cell.imgPicFrame.isHidden = true
            cell.bgViewHeightConstraint.constant = 152
            
        }
        else{
            cell.btnOfferFrom.isHidden = false
            cell.btnOfferTo.isHidden = false
            cell.txtPercentage.isHidden = false
            //cell.btnOffer.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
            cell.lblUploadBannerImage.isHidden = false
            cell.btnAddOfferImage.isHidden = false
            cell.txtValidTo.isHidden = false
            cell.txtValidFrom.isHidden = false
            cell.imgPicFrame.isHidden = false
            cell.bgViewHeightConstraint.constant = 220
        }
        cell.btnAddOfferImage.tag = indexPath.row
        cell.btnAddOfferImage.addTarget(self, action: #selector(AddNewPitchesVC.btnAddOfferImage(sender:)), for: .touchUpInside)
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.ArraySportCategory[indexPath.row].is_offer == 0{
                return 172
        }
        else
        {
            return 240
        }
        
        
    }
    @objc func btnOfferFrom(sender: UIButton){
        print(sender.tag)
        let alert = UIAlertController(title: "Date Picker", message: "Select Date", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let indexPath = IndexPath(row: sender.tag, section: 0)
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddSportsCell else{
                return
            }
            //cell.btnOfferFrom.setTitle(formatter.string(from: date), for: .normal)
            cell.txtValidFrom.text = formatter.string(from: date)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in
            self.tblAddSport.reloadData()
        }
        alert.show()
    }
    @objc func btnOfferTo(sender: UIButton){
        let alert = UIAlertController(title: "Date Picker", message: "Select Date", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let indexPath = IndexPath(row: sender.tag, section: 0)
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddSportsCell else{
                return
            }
            //cell.btnOfferTo.setTitle(formatter.string(from: date), for: .normal)
            cell.txtValidTo.text = formatter.string(from: date)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in
            self.tblAddSport.reloadData()
        }
        alert.show()
    }
    @objc func btnToTime(sender: UIButton){
        let alert = UIAlertController(title: "Date Picker", message: "Select Time", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .time, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            let indexPath = IndexPath(row: sender.tag, section: 0)
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddSportsCell else{
                return
            }
            cell.btnToTime.setTitle(formatter.string(from: date), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in
            self.tblAddSport.reloadData()
        }
        alert.show()
    }
    
    @objc func btnFromDate(sender: UIButton){
        let alert = UIAlertController(title: "Date Picker", message: "Select Date", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let indexPath = IndexPath(row: sender.tag, section: 0)
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddSportsCell else{
                return
            }
            cell.btnFromTime.setTitle(formatter.string(from: date), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in
            self.tblAddSport.reloadData()
        }
        alert.show()
    }
    
    @objc func btnISOfferSelect(uiSwitch: UISwitch){
        if uiSwitch.isOn{
            self.ArraySportCategory[uiSwitch.tag].is_offer = 1
        }
        else{
            self.ArraySportCategory[uiSwitch.tag].is_offer = 0
        }
        self.tblAddSport.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.tblSportsHeight.constant = self.tblAddSport.contentSize.height + 20
        })
    }
    @objc func btnAddOfferImage(sender: UIButton){
        self.isSelectedImage = "4"
        self.OpenAction()
        let indexPath = IndexPath(row: sender.tag, section: 0)
        self.OnSaveImage = { (Image) in
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddSportsCell else{
                return
            }
            cell.imgOfferImage.image = Image
        }
    }
    
}
//MARK: Facility Show
extension AddNewPitchesVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ArrayFacility.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilityCollectionviewCell", for: indexPath) as? FacilityCollectionviewCell else {
            return UICollectionViewCell()
        }
        cell.imgFacilityImage.sd_setImage(with: URL.init(string: self.ArrayFacility[indexPath.row].facilityIcon!), completed: nil)
        cell.imgFacilityImage.image = cell.imgFacilityImage.image?.withRenderingMode(.alwaysTemplate)
        if self.ArrayFacility[indexPath.row].isSelected{
            cell.imgFacilityImage.tintColor = UIColor.colorFromHex(hexString: "#6389FD")
        }
        else{
            cell.imgFacilityImage.tintColor = UIColor.black
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.ArrayFacility[indexPath.row].isSelected{
            self.ArrayFacility[indexPath.row].isSelected = false
            self.facilitycollectionview.reloadData()
        }
        else{
            self.ArrayFacility[indexPath.row].isSelected = true
            self.facilitycollectionview.reloadData()
        }
    }
    
}

//MARK: APICalling
extension AddNewPitchesVC{
    func APICallGetFacilityList() {
        ProviderManager.shared.GetFacilityList { (FacilityDataList, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if FacilityDataList.count > 0{
                self.ArrayFacility = FacilityDataList as! [FacilityData]
                self.facilitycollectionview.delegate = self
                self.facilitycollectionview.dataSource = self
                self.facilitycollectionview.reloadData()
                self.APICallSportCategoryGet()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
                self.APICallSportCategoryGet()
            }
        }
    }
    
    func APICallGetCourtDetail(Court_ID: String) {
        ProviderManager.shared.GetProviderCourtDetail(Court_Id: Court_ID) { (ArrayCourtDetail, error) in
            if error != ""{
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else if ArrayCourtDetail.count > 0{
                self.ArrayCourtDetail = ArrayCourtDetail as! [ProviderDetailData]
                self.ArrayFacility = self.ArrayCourtDetail[0].facilities!
                self.ArraySportCategory = self.ArrayCourtDetail[0].sportDetails!
                self.txtName.text = self.ArrayCourtDetail[0].courtTitle
                self.txtDes.text = self.ArrayCourtDetail[0].descriptionField
                self.txtPrice.text = self.ArrayCourtDetail[0].price
                self.txtLocation.text = self.ArrayCourtDetail[0].location
                self.img1.image = #imageLiteral(resourceName: "square_blank_img")
                self.img2.image = #imageLiteral(resourceName: "square_blank_img")
                self.img3.image = #imageLiteral(resourceName: "square_blank_img")
                for i in 0..<self.ArrayCourtDetail[0].images!.count{
                    if i == 0{
                        self.img1.sd_setImage(with: URL.init(string: self.ArrayCourtDetail[0].images![i].image!), completed: nil)
                    }
                    else if i == 1{
                        self.img2.sd_setImage(with: URL.init(string: self.ArrayCourtDetail[0].images![i].image!), completed: nil)
                    }
                    else if i == 2{
                        self.img3.sd_setImage(with: URL.init(string: self.ArrayCourtDetail[0].images![i].image!), completed: nil)
                    }
                }
                if self.ArrayCourtDetail[0].bookingOnline == "1"{
                    self.OnlineBooking = "1"
                    self.OnlineBookingSwitch.isOn = true
                }
                else{
                    self.OnlineBooking = "0"
                    self.OnlineBookingSwitch.isOn = false
                }
                self.APICallGetFacilityList()
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "no sport available", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func APICallSportCategoryGet(){
        CategoryManager.shared.GetSportCategory { (ArraySportData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArraySportData.count > 0{
                self.TempArraySportCategory = ArraySportData as! [SportCategoryData]
                self.tblAddSport.delegate = self
                self.tblAddSport.dataSource = self
                self.tblAddSport.isScrollEnabled = false
                self.tblSportsHeight.constant = 0
                self.tblAddSport.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.tblSportsHeight.constant = self.tblAddSport.contentSize.height + 20
                })
                
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
    }
    
    func APICallAddNewCourt(param: [String:String],imags: [UIImage?],offerImages:[UIImage?],c_Image: UIImage?,iconImage: UIImage?,isEdit: Bool) {
        print(param)
        ProviderManager.shared.AddNewPitches(withParametrs: param, photo: imags, offerImages: offerImages, videoPath: nil, coverImage: c_Image, iconImage: iconImage,UploadType: "Court",isEdit: isEdit) { (isAdded, error) in
            if isAdded == true{
                    let storyboard = UIStoryboard(name: "Provider", bundle: nil)
                    let VC = storyboard.instantiateViewController(withIdentifier: "SuccessGoToDashaboardVC") as! SuccessGoToDashaboardVC
                    self.navigationController?.pushViewController(VC, animated: true)
//                    let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
//                        self.navigationController?.popViewController(animated: true)
//                    }))
//                    self.present(alert, animated: true, completion: nil)
                }
            else{
                self.offerImages.removeAll()
                self.imagse.removeAll()
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
    func UploadSingleImage(img:[UIImage]) {
        ProviderManager.shared.UploadProviderCourtImage(Court_Id: self.CourtID, photo: img, completion: { (isImageAdded, error) in
            if isImageAdded == true{
                let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.APICallGetCourtDetail(Court_ID: self.CourtID)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        })
    }
    
}
//MARK: PickerView Action and selection
extension AddNewPitchesVC: UIPickerViewDelegate, UIPickerViewDataSource{
    // MARK: Actions Picker view Show
    func openPickerViewController() {
        let style = RMActionControllerStyle.white
        let selectAction = RMAction<UIPickerView>(title: "Select Sports", style: .done) { controller in
            var selectedRows = Int()
            for i in 0 ..< controller.contentView.numberOfComponents {
                //selectedRows.add(controller.contentView.selectedRow(inComponent: i))
                selectedRows = controller.contentView.selectedRow(inComponent: i)
            }
            print("Successfully selected rows: ", selectedRows)
            if self.TempArraySportCategory[selectedRows].isSelected{
                
            }
            else{
                if self.ArraySportCategory.count > 0{
                    if self.ArraySportCategory.contains(where: { (obj) -> Bool in
                        obj.sportId != self.TempArraySportCategory[selectedRows].sportId
                    }){self.ArraySportCategory.append(self.TempArraySportCategory[selectedRows])}
                }
                else{
                    self.ArraySportCategory.append(self.TempArraySportCategory[selectedRows])
                }
                self.tblAddSport.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.tblSportsHeight.constant = self.tblAddSport.contentSize.height
                })
            }
        }
        let cancelAction = RMAction<UIPickerView>(title: "Cancel", style: .cancel) { _ in
            print("Row selection was canceled")
        }
        
        let actionController = RMPickerViewController(style: style, title: title, message: "", select: selectAction, andCancel: cancelAction)!
        //You can enable or disable blur, bouncing and motion effects
        actionController.disableBouncingEffects = false
        actionController.disableMotionEffects = false
        actionController.disableBlurEffects = false
        
        actionController.picker.delegate = self
        actionController.picker.dataSource = self
        
        //On the iPad we want to show the date selection view controller within a popover. Fortunately, we can use iOS 8 API for this! :)
        //(Of course only if we are running on iOS 8 or later)
        if actionController.responds(to: Selector(("popoverPresentationController:"))) && UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            //First we set the modal presentation style to the popover style
            actionController.modalPresentationStyle = UIModalPresentationStyle.popover
            
            //Then we tell the popover presentation controller, where the popover should appear
            if let popoverPresentationController = actionController.popoverPresentationController {
                //popoverPresentationController.sourceView = self.tableView
                //popoverPresentationController.sourceRect = self.tableView.rectForRow(at: IndexPath(row: 0, section: 0))
            }
        }
        //Now just present the date selection controller using the standard iOS presentation method
        present(actionController, animated: true, completion: nil)
    }
    // MARK: UIPickerView Delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.TempArraySportCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return NSString(format: "Row %lu", row) as String;
        return self.TempArraySportCategory[row].sportName
    }
}
//MARK: Image Picker
extension AddNewPitchesVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
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
            OnSaveImage?(image)
        }
    }
}

//MARK: Get Location
extension AddNewPitchesVC{
    fileprivate func GetLocationAndAPICall() {
        
        LocationManager.sharedInstance.getLocation { (location:CLLocation?, error:NSError?) in
            if error != nil {
                self.CheckLocationPermision()
                //Utility.setAlertWith(title: "Error", message: (error?.localizedDescription)!, controller: self)
                return
            }
            guard let _ = location else {
                Utility.setAlertWith(title: "Error", message: "Unable to fetch location", controller: self)
                return
            }
            AppDelegate.sharedDelegate().userLatitude = "\((location?.coordinate.latitude)!)"
            AppDelegate.sharedDelegate().userLongitude = "\((location?.coordinate.longitude)!)"
            if (AppDelegate.sharedDelegate().userLatitude != "" && AppDelegate.sharedDelegate().userLongitude != "" )
            {
                LocationManager.sharedInstance.getReverseGeoCodedLocation(location: location!, completionHandler: { (location, placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }
                    print(placemarks?.country)
                    print(placemarks?.locality)
                    print(placemarks?.subLocality)
                    print(placemarks?.thoroughfare)
                    print(placemarks?.postalCode)
                    print(placemarks?.subThoroughfare)
                    var addressString : String = ""
                    if placemarks?.subLocality != nil {
                        addressString = addressString + (placemarks?.subLocality!)! + ", "
                    }
                    //                    if placemarks?.thoroughfare != nil {
                    //                        addressString = addressString + (placemarks?.thoroughfare!)! + ", "
                    //                    }
                    if placemarks?.locality != nil {
                        addressString = addressString + (placemarks?.locality!)!
                    }
                    //                    if placemarks?.country != nil {
                    //                        addressString = addressString + (placemarks?.country!)! + ", "
                    //                    }
                    //                    if placemarks?.postalCode != nil {
                    //                        addressString = addressString + (placemarks?.postalCode!)! + " "
                    //                    }
                    self.txtLocation.text = addressString
                })
            }
        }
    }
    fileprivate func CheckLocationPermision() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                let alert = UIAlertController(title: "Location Services Disabled", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Go to Settings now", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                    UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)
                }))
                self.present(alert, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                self.GetLocationAndAPICall()
                break
            }
        } else {
            print("Location services are not enabled")
            let alert = UIAlertController(title: "Location Services Disabled", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Go to Settings now", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
                if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") {
                    UIApplication.shared.openURL(url)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

