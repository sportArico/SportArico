

import UIKit
import RMPickerViewController

class AddCourseVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var imgcoverImage: UIImageView!
    @IBOutlet weak var imgAddIcon: UIImageView!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtDes: UITextField!
    @IBOutlet weak var txtSportToolsPrice: UITextField!
    @IBOutlet weak var txtIncludePlacePrice: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var txtNationality: UITextField!
    @IBOutlet weak var txtTearmAndCondition: UITextView!
    
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var facilitycollectionview: UICollectionView!
    @IBOutlet weak var tblAddSport: UITableView!
    @IBOutlet weak var tblSportsHeight: NSLayoutConstraint!
    @IBOutlet weak var PersonalDetailView: UIView!
    @IBOutlet weak var heightPersonalDetailView: NSLayoutConstraint!
    //=== End ===//
    
    
    //MARK: Variable
    var IsAcademy = "1"
    var ArrayFacility:[FacilityData] = []
    var ArraySportCategory:[SportCategoryData] = []
    var TempArraySportCategory:[SportCategoryData] = []
    var datePicker : UIDatePicker!
    var picker = UIImagePickerController()
    var isSelectedImage = "0"
    var isEdit = false
    var Cources_ID = ""
    var ArrayCourcesDetail:[ProviderCourcesDetailData] = []
    var SportsStrinArray:[String] = []
    var FacilityStringArray:[String] = []
    //=== End ===//
    
    fileprivate func SetUpUI() {
        btnNo.layer.cornerRadius = btnNo.layer.frame.width / 2
        btnNo.clipsToBounds = true
        btnYes.layer.cornerRadius = btnYes.layer.frame.width / 2
        btnYes.clipsToBounds = true
        txtTearmAndCondition.layer.borderWidth = 1
        txtTearmAndCondition.layer.borderColor = UIColor.gray.cgColor
        txtTearmAndCondition.placeholder = "Add Tearm And Condition"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        self.tblAddSport.register(UINib(nibName: "AddCourcesSportsCell", bundle: nil), forCellReuseIdentifier: "AddCourcesSportsCell")
        
        if isEdit{
            self.APICallGetCourcesDetail(Cources_ID: self.Cources_ID)
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
    @IBAction func btnNo(_ sender: Any) {
        IsAcademy = "0"
        btnNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
        btnYes.setImage(UIImage(named:""), for: .normal)
        self.PersonalDetailView.isHidden = true
        self.heightPersonalDetailView.constant = 0
    }
    @IBAction func btnYes(_ sender: Any) {
        IsAcademy = "1"
        btnNo.setImage(UIImage(named:""), for: .normal)
        btnYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
        self.PersonalDetailView.isHidden = false
        self.heightPersonalDetailView.constant = 220
    }
    
    @IBAction func img1Select(_ sender: UITapGestureRecognizer) {
        self.isSelectedImage = "1"
        self.OpenAction()
    }
    @IBAction func img2Select(_ sender: UITapGestureRecognizer) {
        self.isSelectedImage = "2"
        self.OpenAction()
    }
    @IBAction func img3Select(_ sender: UITapGestureRecognizer) {
        self.isSelectedImage = "3"
        self.OpenAction()
    }
    @IBAction func coverImage(_ sender: UITapGestureRecognizer) {
        self.isSelectedImage = "4"
        self.OpenAction()
    }
    @IBAction func imgAddIcon(_ sender: UITapGestureRecognizer) {
        self.isSelectedImage = "5"
        self.OpenAction()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        guard (txtName.text  == "" ? nil : txtName.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Name", controller: self)
            return
        }
        guard (txtLocation.text  == "" ? nil : txtLocation.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Location", controller: self)
            return
        }
        guard (txtSportToolsPrice.text  == "" ? nil : txtSportToolsPrice.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Sport Tools Price", controller: self)
            return
        }
        guard (txtIncludePlacePrice.text  == "" ? nil : txtIncludePlacePrice.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Include Places Price", controller: self)
            return
        }
        guard (txtDes.text  == "" ? nil : txtDes.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Description", controller: self)
            return
        }
        
        if IsAcademy == "1"{
            guard (txtAge.text  == "" ? nil : txtAge.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter Age", controller: self)
                return
            }
            guard (txtGender.text  == "" ? nil : txtGender.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Select Gender", controller: self)
                return
            }
            guard (txtMobileNumber.text  == "" ? nil : txtMobileNumber.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter Mobile Number", controller: self)
                return
            }
            guard (txtNationality.text  == "" ? nil : txtNationality.text) != nil else {
                Utility.setAlertWith(title: "Alert", message: "Please Enter Nationality", controller: self)
                return
            }
        }
        
        var customeArray:[CustomeProviderCourcesModelRoot] = []
        var TimeFrom = ""
        var TimeTo = ""
        var price = ""
        var discount = ""
        var offerFrom = ""
        var offerTo = ""
        var p_name = ""
        var p_price = ""
        var oTitle = ""
        var oDesc = ""
        
        
        for i in 0..<self.ArraySportCategory.count{
            let indexPath = IndexPath(row: i, section: 0)
            guard let cell = tblAddSport.cellForRow(at: indexPath) as? AddCourcesSportsCell else{
                return
            }
            
            if let offerFromdata = cell.btnFromTime.currentTitle, !offerFromdata.isEmpty{
                TimeFrom = offerFromdata
            }
            else
            {
                Utility.setAlertWith(title: "Alert", message: "Please Enter From Time.", controller: self)
                return
            }
            
            if let offerTodata = cell.btnToTime.currentTitle, !offerTodata.isEmpty{
                TimeTo = offerTodata
            }
            else
            {
                Utility.setAlertWith(title: "Alert", message: "Please Enter To Time.", controller: self)
                return
            }
            
            if let priceTodata = cell.txtPrice.text, !priceTodata.isEmpty{
                price = priceTodata
            }
            else
            {
                Utility.setAlertWith(title: "Alert", message: "Please Enter Price.", controller: self)
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
                
                
                if let offerFromdata = cell.btnOfferFrom.currentTitle, !offerFromdata.isEmpty {
                    offerFrom = offerFromdata
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer From.", controller: self)
                    return
                }
                
                if let offerTodata = cell.btnOfferTo.currentTitle, !offerTodata.isEmpty {
                    offerTo = offerTodata
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer To.", controller: self)
                    return
                }
                
                if let offerTitle = cell.txtTitle.text, !offerTitle.isEmpty {
                    oTitle = offerTitle
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer Title.", controller: self)
                    return
                }
                
                if let offerDesc = cell.txtDesc.text, !offerDesc.isEmpty {
                    oDesc = offerDesc
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "Please Enter Offer Description.", controller: self)
                    return
                }
                
            }
            if let p_namedata = cell.txtPakageName.text, !p_namedata.isEmpty{
                p_name = p_namedata
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "Please Enter Package Name.", controller: self)
                return
            }
            
            if let p_pricedata = cell.txtPakageName.text, !p_pricedata.isEmpty{
                p_price = p_pricedata
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "Please Enter Package Price.", controller: self)
                return
            }
            
            
            let availabletimeobj:[CustomeProviderModelAvailableDatetime] = [CustomeProviderModelAvailableDatetime(availableDate: TimeFrom, availableTime: TimeTo)]
            let pakageobj:[CustomeProviderModelpackages] = [CustomeProviderModelpackages(package_name: p_name, price: p_price)]
            
            let obj:CustomeProviderCourcesModelRoot = CustomeProviderCourcesModelRoot(availableDatetime: availabletimeobj, packages: pakageobj, discount: discount, is_offer: self.ArraySportCategory[i].is_offer ?? 0, sport_id: Int(self.ArraySportCategory[i].sportId!) ?? 0, valid_to: offerTo, valid_from: offerFrom,offer_title:oTitle,offer_description:oDesc)
            
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
            return
        }
        let imagse:[UIImage] = []
        var offerImages:[UIImage] = []
        offerImages.append(img1.image!)
        offerImages.append(img2.image!)
        offerImages.append(img3.image!)
        var facility:[String] = []
        for item in self.ArrayFacility{
            if item.isSelected{
                facility.append(item.facilityId!)
            }
        }
        let stringfacility = facility.joined(separator: ",")
        var SportArray:[String] = []
        for item in self.ArraySportCategory{
           // if item.isSelected{
                SportArray.append(item.sportId!)
            //}
        }
        let stringSport = SportArray.joined(separator: ",")
        if isEdit{
            let param = ["user_id":UserManager.shared.currentUser?.user_id,"course_title":txtName.text!,"latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"sport_tools_price":txtSportToolsPrice.text!,"include_place_price":txtIncludePlacePrice.text!,"facilities":stringfacility,"sport_ids":stringSport,"location":txtLocation.text!,"description":txtDes.text!,"sport_available":SportAvailableString,"is_academy":self.IsAcademy,"terms_and_condition":txtTearmAndCondition.text!,"gender":txtGender.text!,"age":txtAge.text!,"mobile":txtMobileNumber.text!,"nationality":txtNationality.text!,"course_id":self.Cources_ID]
            self.APICallAddNewCources(param: param as! [String : String], Images: imagse, c_Image: nil, iconImage: nil, offerImage: offerImages, isEdit: true)
        }
        else{
            let param = ["user_id":UserManager.shared.currentUser?.user_id,"course_title":txtName.text!,"latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"sport_tools_price":txtSportToolsPrice.text!,"include_place_price":txtIncludePlacePrice.text!,"facilities":stringfacility,"sport_ids":stringSport,"location":txtLocation.text!,"description":txtDes.text!,"sport_available":SportAvailableString,"is_academy":self.IsAcademy,"terms_and_condition":txtTearmAndCondition.text!,"gender":txtGender.text!,"age":txtAge.text!,"mobile":txtMobileNumber.text!,"nationality":txtNationality.text!]
            self.APICallAddNewCources(param: param as! [String : String], Images: imagse, c_Image: self.imgcoverImage.image, iconImage: self.imgAddIcon.image, offerImage: offerImages, isEdit: false)
            
            print(param)
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

extension AddCourseVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArraySportCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddCourcesSportsCell", for: indexPath) as? AddCourcesSportsCell else {
                return UITableViewCell()
            }
            cell.lblSportName.text = self.ArraySportCategory[indexPath.row].sportName
            cell.imgSportsImage.sd_setImage(with: URL.init(string: self.ArraySportCategory[indexPath.row].sportIcon!), completed: nil)
            cell.btnFromTime.tag = indexPath.row
            cell.btnFromTime.addTarget(self, action: #selector(AddCourseVC.btnFromDate(sender:)), for: .touchUpInside)
            
            cell.btnToTime.tag = indexPath.row
            cell.btnToTime.addTarget(self, action: #selector(AddCourseVC.btnToTime(sender:)), for: .touchUpInside)
        
            cell.btnOfferFrom.tag = indexPath.row
            cell.btnOfferFrom.addTarget(self, action: #selector(AddCourseVC.btnOfferFrom(sender:)), for: .touchUpInside)
        
            cell.btnOfferTo.tag = indexPath.row
            cell.btnOfferTo.addTarget(self, action: #selector(AddCourseVC.btnOfferTo(sender:)), for: .touchUpInside)
        
            cell.btnOffer.tag = indexPath.row
            cell.btnOffer.addTarget(self, action: #selector(AddCourseVC.btnISOfferSelect(sender:)), for: .touchUpInside)
            if self.ArraySportCategory[indexPath.row].is_offer == 0{
                cell.btnOfferFrom.isHidden = true
                cell.btnOfferTo.isHidden = true
                cell.txtPercentage.isHidden = true
                cell.btnOffer.setImage(UIImage(named: ""), for: .normal)
            }
            else{
                cell.btnOfferFrom.isHidden = false
                cell.btnOfferTo.isHidden = false
                cell.txtPercentage.isHidden = false
                cell.btnOffer.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
            }
            
            return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.ArraySportCategory[indexPath.row].is_offer == 0{
            return 175.0
        }
        else
        {
            return 279.0
        }
        
    }
    @objc func btnOfferFrom(sender: UIButton){
        print(sender.tag)
        let alert = UIAlertController(title: "Date Picker", message: "Select Date", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let indexPath = IndexPath(row: sender.tag, section: 0)
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddCourcesSportsCell else{
                return
            }
            cell.btnOfferFrom.setTitle(formatter.string(from: date), for: .normal)
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
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddCourcesSportsCell else{
                return
            }
            cell.btnOfferTo.setTitle(formatter.string(from: date), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in
            self.tblAddSport.reloadData()
        }
        alert.show()
    }
    @objc func btnToTime(sender: UIButton){
        let alert = UIAlertController(title: "Date Picker", message: "Select Time", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let indexPath = IndexPath(row: sender.tag, section: 0)
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddCourcesSportsCell else{
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
            guard let cell = self.tblAddSport.cellForRow(at: indexPath) as? AddCourcesSportsCell else{
                return
            }
            cell.btnFromTime.setTitle(formatter.string(from: date), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in
            self.tblAddSport.reloadData()
        }
        alert.show()
    }
    
    @objc func btnISOfferSelect(sender: UIButton){
        if self.ArraySportCategory[sender.tag].is_offer == 0{
            self.ArraySportCategory[sender.tag].is_offer = 1
        }
        else{
            self.ArraySportCategory[sender.tag].is_offer = 0
        }
        self.tblAddSport.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.tblSportsHeight.constant = self.tblAddSport.contentSize.height + 20
        })
    }
    
}
//MARK: Facility Show
extension AddCourseVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
extension AddCourseVC{
    func APICallGetFacilityList() {
        ProviderManager.shared.GetFacilityList { (FacilityDataList, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if FacilityDataList.count > 0{
                self.ArrayFacility = FacilityDataList as! [FacilityData]
                for i in 0..<self.ArrayFacility.count{
                    let fid = self.ArrayFacility[i].facilityId
                    for fids in self.FacilityStringArray{
                        if fids == fid{
                            self.ArrayFacility[i].isSelected = true
                        }
                    }
                }
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
    
    func APICallGetCourcesDetail(Cources_ID: String) {
        ProviderManager.shared.GetProviderCourcesDetail(Cources_Id: Cources_ID) { (ArrayCourcesDetail, error) in
            if error != ""{
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else if ArrayCourcesDetail.count > 0{
                self.ArrayCourcesDetail = ArrayCourcesDetail as! [ProviderCourcesDetailData]
                //self.ArrayFacility = self.ArrayCourcesDetail[0].facilities!
                self.ArraySportCategory = self.ArrayCourcesDetail[0].sportDetails!
                let Sportids = self.ArrayCourcesDetail[0].sports!
                self.SportsStrinArray = Sportids.components(separatedBy: ",")
                let FacilitieyIds = self.ArrayCourcesDetail[0].Facilities_id!
                self.FacilityStringArray = FacilitieyIds.components(separatedBy: ",")
                self.tblAddSport.delegate = self
                self.tblAddSport.dataSource = self
                self.tblAddSport.isScrollEnabled = false
                self.tblSportsHeight.constant = 0
//                for i in 0..<self.ArraySportCategory.count{
//                    let availabletime:AvailableDatetime = AvailableDatetime(availableDate: "", availableTime: "")
//                    self.ArraySportCategory[i].availableDatetime?.append(availabletime)
//                    self.ArraySportCategory[i].isSelected = true
//                }
                self.tblAddSport.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    self.tblSportsHeight.constant = self.tblAddSport.contentSize.height + 20
                })
                for i in 0..<self.ArrayFacility.count{
                    self.ArrayFacility[i].isSelected = true
                }
                self.facilitycollectionview.delegate = self
                self.facilitycollectionview.dataSource = self
                self.facilitycollectionview.reloadData()
                self.txtName.text = self.ArrayCourcesDetail[0].courseTitle
                self.txtDes.text = self.ArrayCourcesDetail[0].descriptionField
                self.txtSportToolsPrice.text = self.ArrayCourcesDetail[0].sportToolsPrice
                self.txtIncludePlacePrice.text = self.ArrayCourcesDetail[0].includePlacePrice
                self.txtTearmAndCondition.text = self.ArrayCourcesDetail[0].termsAndCondition
                self.imgcoverImage.sd_setImage(with: URL.init(string: self.ArrayCourcesDetail[0].coverPhoto!), completed: nil)
                self.imgAddIcon.sd_setImage(with: URL.init(string: self.ArrayCourcesDetail[0].icon!), completed: nil)
                self.txtLocation.text = self.ArrayCourcesDetail[0].location
//                for i in 0..<self.ArrayCourcesDetail[0].images!.count{
//                    if i == 0{
//                        self.img1.sd_setImage(with: URL.init(string: self.ArrayCourtDetail[0].images![i].image!), completed: nil)
//                    }
//                    else if i == 1{
//                        self.img2.sd_setImage(with: URL.init(string: self.ArrayCourtDetail[0].images![i].image!), completed: nil)
//                    }
//                    else if i == 2{
//                        self.img3.sd_setImage(with: URL.init(string: self.ArrayCourtDetail[0].images![i].image!), completed: nil)
//                    }
//                }
                if self.ArrayCourcesDetail[0].isAcademy == "1"{
                    self.IsAcademy = "1"
                    self.btnNo.setImage(UIImage(named:""), for: .normal)
                    self.btnYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
                    self.PersonalDetailView.isHidden = false
                    self.heightPersonalDetailView.constant = 280
                    self.txtAge.text = self.ArrayCourcesDetail[0].contactInfo?.age
                    self.txtGender.text = self.ArrayCourcesDetail[0].contactInfo?.gender
                    self.txtMobileNumber.text = self.ArrayCourcesDetail[0].contactInfo?.mobile
                    self.txtNationality.text = self.ArrayCourcesDetail[0].contactInfo?.nationality
                }
                else{
                    self.IsAcademy = "0"
                    self.btnNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
                    self.btnYes.setImage(UIImage(named:""), for: .normal)
                    self.PersonalDetailView.isHidden = true
                    self.heightPersonalDetailView.constant = 0
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
    
    func APICallAddNewCources(param: [String:String],Images: [UIImage?],c_Image: UIImage?,iconImage: UIImage?,offerImage: [UIImage?],isEdit: Bool) {
        print(param)
        ProviderManager.shared.AddNewPitches(withParametrs: param, photo: Images, offerImages: offerImage, videoPath: nil, coverImage: c_Image, iconImage: iconImage,UploadType: "Cources",isEdit: isEdit) { (isAdded, error) in
            if isAdded == true{
                let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
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
    
    func UploadSingleImageIcon(img: UIImage?,icon: UIImage?) {
        ProviderManager.shared.UploadProviderCourcesIconImage(course_id: self.Cources_ID, Image: img, Icon: icon) { (isImageAdded, error) in
            if isImageAdded == true{
                let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    if img != nil{
                        self.imgcoverImage.image = img
                    }
                    else if icon != nil{
                        self.imgAddIcon.image = icon
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
}
//MARK: PickerView Action and selection
extension AddCourseVC: UIPickerViewDelegate, UIPickerViewDataSource{
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
extension AddCourseVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
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
            self.img1.image = image
        }
        else if self.isSelectedImage == "2"{
            self.img3.image = image
        }
        else if self.isSelectedImage == "3"{
            self.img2.image = image
        }
        else if self.isSelectedImage == "4"{
            if isEdit{
                self.UploadSingleImageIcon(img: image, icon: nil)
            }
            else{
                self.imgcoverImage.image = image
            }
        }
        else if self.isSelectedImage == "5"{
            if isEdit{
                self.UploadSingleImageIcon(img: nil, icon: image)
            }
            else{
                self.imgAddIcon.image = image
            }
        }
    }
}


