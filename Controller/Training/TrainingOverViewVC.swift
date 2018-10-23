

import UIKit
import RMPickerViewController
import XLPagerTabStrip

class TrainingOverViewVC: UIViewController,IndicatorInfoProvider {
    
    var itemInfo: IndicatorInfo = IndicatorInfo(title: "OverView")
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    //MARK: Main Outlet
    @IBOutlet weak var lblRunning: UILabel!
    @IBOutlet weak var imgRunning: UIImageView!
    @IBOutlet weak var btnRunning: UIButton!
    @IBOutlet weak var lblNavigate: UILabel!
    @IBOutlet weak var imgNavigate: UIImageView!
    @IBOutlet weak var btnNavigate: UIButton!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var imgContact: UIImageView!
    @IBOutlet weak var btnContact: UIButton!
    @IBOutlet weak var lblBookmark: UILabel!
    @IBOutlet weak var imgBookmark: UIImageView!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var imgBGImage: UIImageView!
    @IBOutlet weak var imgUserImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var Sportcollectionview: UICollectionView!
    @IBOutlet weak var DateSelectCollectionview: UICollectionView!
    @IBOutlet weak var TimeSelectCollectionview: UICollectionView!
    @IBOutlet weak var ContactInfoView: UIView!
    @IBOutlet weak var RunningSessionView: UIView!
    @IBOutlet weak var btnSportSelect: UIButton!
    @IBOutlet weak var btnPakageSelect: UIButton!
    @IBOutlet weak var lblSportToolPrice: UILabel!
    @IBOutlet weak var lblSportPlaces: UILabel!
    @IBOutlet weak var SwitchSportToolOn: UISwitch!
    @IBOutlet weak var SwitchSportPlacesOn: UISwitch!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var PakagePriceWidth: NSLayoutConstraint!
    //=== End ===//
    
    //MARK: Sppiner Outlet
    @IBOutlet weak var lblSportCategoryType: UILabel!
    @IBOutlet weak var imgSportCategoryImage: UIImageView!
    @IBOutlet weak var lblPakageName: UILabel!
    @IBOutlet weak var lblPakageDes: UILabel!
    @IBOutlet weak var lblPakagePrice: UILabel!
    //=== End === //
    
    //MARK: Contact Info Detail Outlet
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var txtTermsAndCondi: UITextView!
    //=== End ===//
    
    
    //MARK: Variable
    var Cources_ID = ""
    var TrainingSportDetailData:TrainingDetailData?
    var isPakageSelect = false
    var Current_Section = 0
    var Total = Float()
    var PakagePrice = Float()
    var isIncludPlace = "1"
    var isIncludSport_tool = "0"
    var book_avail_timeIds:[String] = []
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ContactInfoView.isHidden = true
        RunningSessionView.isHidden = false
        Sportcollectionview.register(UINib(nibName: "SportCategoryCell", bundle: nil), forCellWithReuseIdentifier: "SportCategoryCell")
        self.imgSportCategoryImage.contentMode = .scaleAspectFill
        self.imgSportCategoryImage.layer.cornerRadius = self.imgSportCategoryImage.layer.frame.height / 2
        self.imgSportCategoryImage.clipsToBounds = true
        self.APICallTrainingDetail(lat: AppDelegate.sharedDelegate().userLatitude, long: AppDelegate.sharedDelegate().userLongitude, CourseId: self.Cources_ID)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnShare(_ sender: Any) {
        let message = "Try this app to "
        //if let link = NSURL(string: "https://itunes.apple.com/us/app/easyvent/id1401839200?ls=1&mt=8") {
        let objectsToShare = [message] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        //navigationController?.present(activityVC, animated: true, completion: nil)
        // }
    }
    
    @IBAction func btnRunning(_ sender: Any) {
        self.SelectedViewSetUI(tag: 0)
        ContactInfoView.isHidden = true
        RunningSessionView.isHidden = false
    }
    @IBAction func btnNavigate(_ sender: Any) {
        self.SelectedViewSetUI(tag: 1)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "NavigateVC") as! NavigateVC
        vc.TrainingSportDetailData = self.TrainingSportDetailData
        vc.MapType = "cources"
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnContact(_ sender: Any) {
        self.SelectedViewSetUI(tag: 2)
        ContactInfoView.isHidden = false
        RunningSessionView.isHidden = true
    }
    @IBAction func btnBookmark(_ sender: Any) {
        self.SelectedViewSetUI(tag: 3)
        TrainingManager.shared.AddToBookMark(User_Id: (UserManager.shared.currentUser?.user_id)!, CourcesID: self.Cources_ID) { (isbookmark, error) in
            if isbookmark == true{
                Utility.setAlertWith(title: "Success", message: error, controller: self)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
    }
    
    @IBAction func btnSportSelect(_ sender: Any) {
        self.isPakageSelect = false
        if self.TrainingSportDetailData!.sports!.count > 0{
            self.openPickerViewController(isPakageSelect: false)
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "no sport available.", controller: self)
        }
    }
    @IBAction func btnPakageSelect(_ sender: Any) {
        self.isPakageSelect = true
        if self.TrainingSportDetailData!.packages!.count > 0{
            self.openPickerViewController(isPakageSelect: true)
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "no pakage available.", controller: self)
        }
    }
    @IBAction func SwitchSportToolOn(_ sender: Any) {
        if SwitchSportToolOn.isOn{
            self.isIncludSport_tool = "1"
            self.Total += Float(self.TrainingSportDetailData?.sportToolsPrice ?? "0.0")!
        }
        else{
            self.isIncludSport_tool = "0"
            self.Total -= Float(self.TrainingSportDetailData?.sportToolsPrice ?? "0.0")!
        }
        self.lblTotal.text = "AED \(self.Total)"
    }
    @IBAction func SwitchSportPlacesOn(_ sender: Any) {
        if SwitchSportPlacesOn.isOn{
            self.isIncludPlace = "1"
            self.Total += Float(self.TrainingSportDetailData?.includePlacePrice ?? "0.0")!
        }
        else{
            self.isIncludPlace = "0"
            self.Total -= Float(self.TrainingSportDetailData?.includePlacePrice ?? "0.0")!
        }
        self.lblTotal.text = "AED \(self.Total)"
    }
    
    @IBAction func btnBookNow(_ sender: Any) {
        for i in 0..<self.TrainingSportDetailData!.availableTime!.count{
            if self.TrainingSportDetailData!.availableTime![i].isDayselect{
                for j in 0..<self.TrainingSportDetailData!.availableTime![i].availableTime!.count{
                    if (self.TrainingSportDetailData?.availableTime![i].availableTime![j].isTimeselect)!{
                        self.book_avail_timeIds.append((self.TrainingSportDetailData?.availableTime![i].availableTime![j].bookAvailId)!)
                    }
                }
            }
        }
        if self.book_avail_timeIds.count > 0 {
            
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "Please select one time to continue process...", controller: self)
            return
        }
        let storyboard = UIStoryboard(name: "Training", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProceedToPayCourcesVC") as! ProceedToPayCourcesVC
        vc.TrainingSportDetailData = self.TrainingSportDetailData
        vc.isIncludPlace = self.isIncludPlace
        vc.isIncludSport_tool = self.isIncludSport_tool
        vc.book_avail_timeIds = self.book_avail_timeIds
        vc.Total = self.Total
        navigationController?.pushViewController(vc, animated: true)
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

//MARK: SetUp UI
extension TrainingOverViewVC{
    func SetUpUI(data: TrainingDetailData) {
        imgBGImage.sd_setImage(with: URL.init(string: data.coverPhoto!), completed: nil)
        imgUserImage.sd_setImage(with: URL.init(string: data.icon!), completed: nil)
        lblName.text = data.courseTitle
        self.Sportcollectionview.delegate = self
        self.Sportcollectionview.dataSource = self
        self.Sportcollectionview.reloadData()
        self.DateSelectCollectionview.delegate = self
        self.DateSelectCollectionview.dataSource = self
        self.DateSelectCollectionview.reloadData()
        self.TimeSelectCollectionview.delegate = self
        self.TimeSelectCollectionview.dataSource = self
        self.TimeSelectCollectionview.reloadData()
        lblSportToolPrice.text = " AED \(data.sportToolsPrice ?? "") "
        lblSportPlaces.text = " AED \(data.includePlacePrice ?? "") "
        if data.sports!.count > 0{
            lblSportCategoryType.text = data.sports![0].sportName
            imgSportCategoryImage.sd_setImage(with: URL.init(string: data.sports![0].sportImage!), completed: nil)
        }
        if data.packages!.count > 0{
            lblPakageDes.text = data.packages![0].packageName
            lblPakagePrice.text = "AED \(data.packages![0].price ?? "")"
            self.PakagePrice = Float(data.packages![0].price ?? "0.0") ?? 0.0
        }
        self.Total += self.PakagePrice
        self.Total += Float(data.includePlacePrice ?? "")!
        self.lblTotal.text = "AED \(self.Total)"
        self.PakagePriceWidth.constant = self.lblPakagePrice.intrinsicContentSize.width
    }
    func SetUpUIContactInfo(data: TrainingSportContactInfo) {
        lblGender.text = data.gender
        lblAge.text = data.age
        lblLocation.text = self.TrainingSportDetailData?.location
        lblNationality.text = self.TrainingSportDetailData?.country
        lblMobile.text = data.mobile
        lblAccountType.text = data.accountType
        txtTermsAndCondi.text = self.TrainingSportDetailData?.termsAndCondition
    }
    func SelectedViewSetUI(tag: Int){
        switch tag {
        case 0:
            self.imgRunning.tintColor = UIColor.colorFromHex(hexString: "#6389FD")
            self.lblRunning.textColor = UIColor.colorFromHex(hexString: "#6389FD")
            self.imgNavigate.tintColor = UIColor.lightGray
            self.lblNavigate.textColor = UIColor.lightGray
            self.imgContact.tintColor = UIColor.lightGray
            self.lblContact.textColor = UIColor.lightGray
            self.imgBookmark.tintColor = UIColor.lightGray
            self.lblBookmark.textColor = UIColor.lightGray
            break
        case 1:
            self.imgRunning.tintColor = UIColor.lightGray
            self.lblRunning.textColor = UIColor.lightGray
            self.imgNavigate.tintColor = UIColor.colorFromHex(hexString: "#6389FD")
            self.lblNavigate.textColor = UIColor.colorFromHex(hexString: "#6389FD")
            self.imgContact.tintColor = UIColor.lightGray
            self.lblContact.textColor = UIColor.lightGray
            self.imgBookmark.tintColor = UIColor.lightGray
            self.lblBookmark.textColor = UIColor.lightGray
            break
        case 2:
            self.imgRunning.tintColor = UIColor.lightGray
            self.lblRunning.textColor = UIColor.lightGray
            self.imgNavigate.tintColor = UIColor.lightGray
            self.lblNavigate.textColor = UIColor.lightGray
            self.imgContact.tintColor = UIColor.colorFromHex(hexString: "#6389FD")
            self.lblContact.textColor = UIColor.colorFromHex(hexString: "#6389FD")
            self.imgBookmark.tintColor = UIColor.lightGray
            self.lblBookmark.textColor = UIColor.lightGray
            break
        case 3:
            self.imgRunning.tintColor = UIColor.lightGray
            self.lblRunning.textColor = UIColor.lightGray
            self.imgNavigate.tintColor = UIColor.lightGray
            self.lblNavigate.textColor = UIColor.lightGray
            self.imgContact.tintColor = UIColor.lightGray
            self.lblContact.textColor = UIColor.lightGray
            self.imgBookmark.tintColor = UIColor.colorFromHex(hexString: "#6389FD")
            self.lblBookmark.textColor = UIColor.colorFromHex(hexString: "#6389FD")
            break
        default:
            break
        }
    }
}

//MARK: Sport Category Show...
extension TrainingOverViewVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == DateSelectCollectionview{
            return 1
        }
        else if collectionView == TimeSelectCollectionview{
            return 1
        }
        else{
            return 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == DateSelectCollectionview{
            return (self.TrainingSportDetailData?.availableTime?.count)!
        }
        else if collectionView == TimeSelectCollectionview{
            if self.TrainingSportDetailData!.availableTime!.count > 0{
                return (self.TrainingSportDetailData!.availableTime![Current_Section].availableTime?.count)!
            }
            else{
                return 0
            }
        }
        else{
            return (self.TrainingSportDetailData?.sports?.count)!
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == DateSelectCollectionview{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectDayCell", for: indexPath) as? SelectDayCell else {
                return UICollectionViewCell()
            }
            cell.lblDay.text = "\(getDay((self.TrainingSportDetailData?.availableTime![indexPath.row].bookAvailDate)!) ?? 0)"
            cell.lblDay.layer.cornerRadius = cell.lblDay.layer.frame.height / 2
            cell.lblDay.clipsToBounds = true
            cell.lblDayName.text = "\(getDayNameString((self.TrainingSportDetailData?.availableTime![indexPath.row].bookAvailDate)!) ?? "")"
            if (self.TrainingSportDetailData?.availableTime![indexPath.row].isDayselect)!{
                cell.lblDay.backgroundColor = UIColor.colorFromHex(hexString: "#6389FD")
                cell.lblDay.textColor = UIColor.white
            }
            else{
                cell.lblDay.backgroundColor = UIColor.colorFromHex(hexString: "#EBEBF1")
                cell.lblDay.textColor = UIColor.black
            }
            return cell
        }
        else if collectionView == TimeSelectCollectionview{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectTimeCell", for: indexPath) as? SelectTimeCell else {
                return UICollectionViewCell()
            }
            cell.lblTime.text = "\(getTimeString((self.TrainingSportDetailData?.availableTime![Current_Section].availableTime![indexPath.row].bookAvailTime)!) ?? "")"
            cell.lblTime.layer.cornerRadius = 5
            cell.lblTime.clipsToBounds = true
            if (self.TrainingSportDetailData?.availableTime![Current_Section].availableTime![indexPath.row].isTimeselect)!{
                cell.lblTime.backgroundColor = UIColor.colorFromHex(hexString: "#6389FD")
                cell.lblTime.textColor = UIColor.white
            }
            else{
                cell.lblTime.backgroundColor = UIColor.colorFromHex(hexString: "#EBEBF1")
                cell.lblTime.textColor = UIColor.black
            }
            return cell
        }
        else{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCategoryCell", for: indexPath) as? SportCategoryCell else {
                return UICollectionViewCell()
            }
            cell.imgSportImage.sd_setImage(with: URL.init(string: (self.TrainingSportDetailData?.sports![indexPath.row].sportImage!)!), completed: nil)
            cell.lblSportName.text = self.TrainingSportDetailData?.sports![indexPath.row].sportName
            cell.lblSportName.isHidden = false
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        if collectionView == DateSelectCollectionview{
            return CGSize(width: 50, height: 65)
        }
        else if collectionView == TimeSelectCollectionview{
            return CGSize(width: 100, height: 60)
        }
        else{
            return CGSize(width: 50, height: 50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == DateSelectCollectionview{
            return UIEdgeInsetsMake(5, 5, 5, 5)
        }
        else if collectionView == TimeSelectCollectionview{
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else{
            let cellWidth : CGFloat = 165.0
            let numberOfCells = floor(self.view.frame.size.width / cellWidth)
            let edgeInsets = (self.view.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
            return UIEdgeInsetsMake(15, edgeInsets, 0, edgeInsets)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == DateSelectCollectionview{
            for i in 0..<(self.TrainingSportDetailData?.availableTime!)!.count{
                self.TrainingSportDetailData?.availableTime![i].isDayselect = false
            }
            self.TrainingSportDetailData?.availableTime![indexPath.row].isDayselect = true
            self.DateSelectCollectionview.reloadData()
            self.Current_Section = indexPath.row
            self.TimeSelectCollectionview.reloadData()
        }
        else if collectionView == TimeSelectCollectionview{
            if (self.TrainingSportDetailData?.availableTime![Current_Section].availableTime![indexPath.row].isTimeselect)!{
                self.TrainingSportDetailData?.availableTime![Current_Section].availableTime![indexPath.row].isTimeselect = false
            }
            else{
                self.TrainingSportDetailData?.availableTime![Current_Section].availableTime![indexPath.row].isTimeselect = true
            }
            self.TimeSelectCollectionview.reloadData()
        }
        else{
            
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    //        if collectionView == DateSelectCollectionview{
    //            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.clear
    //        }
    //    }
    
}

//MARK: API Calling...
extension TrainingOverViewVC{
    func APICallTrainingDetail(lat: String,long: String,CourseId: String) {
        TrainingManager.shared.GetTrainingDetail(lat: lat, long: long, CourcesID: CourseId) { (TrainingDetailData, error) in
            if TrainingDetailData != nil{
                self.TrainingSportDetailData = TrainingDetailData
                self.SetUpUI(data: TrainingDetailData!)
                self.SetUpUIContactInfo(data: (self.TrainingSportDetailData?.contactInfo)!)
            }
            else{
                if error != ""{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
                else{
                    Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
                }
            }
        }
    }
}
//MARK: PickerView Action and selection
extension TrainingOverViewVC: UIPickerViewDelegate, UIPickerViewDataSource{
    // MARK: Actions Picker view Show
    func openPickerViewController(isPakageSelect:Bool = false) {
        let style = RMActionControllerStyle.white
        var title = ""
        if isPakageSelect{
            title = "Select Pakage"
        }
        else{
            title = "Select Sports"
        }
        let selectAction = RMAction<UIPickerView>(title: "Select", style: .done) { controller in
            var selectedRows = Int()
            for i in 0 ..< controller.contentView.numberOfComponents {
                //selectedRows.add(controller.contentView.selectedRow(inComponent: i))
                selectedRows = controller.contentView.selectedRow(inComponent: i)
            }
            print("Successfully selected rows: ", selectedRows)
            if isPakageSelect{
                self.lblPakageDes.text = self.TrainingSportDetailData?.packages![selectedRows].packageName
                self.lblPakagePrice.text = "AED \(self.TrainingSportDetailData?.packages![selectedRows].price ?? "")"
                self.Total -= self.PakagePrice
                self.PakagePrice = Float(self.TrainingSportDetailData?.packages![selectedRows].price ?? "0.0") ?? 0.0
                self.Total += self.PakagePrice
                self.lblTotal.text = "AED \(self.Total)"
                self.PakagePriceWidth.constant = self.lblPakagePrice.intrinsicContentSize.width
            }
            else{
                self.lblSportCategoryType.text = self.TrainingSportDetailData?.sports![selectedRows].sportName
                self.imgSportCategoryImage.sd_setImage(with: URL.init(string: (self.TrainingSportDetailData?.sports![selectedRows].sportImage!)!), completed: nil)
            }
        }
        let cancelAction = RMAction<UIPickerView>(title: "Cancel", style: .cancel) { _ in
            print("Row selection was canceled")
        }
        
        let actionController = RMPickerViewController(style: style, title: title, message: "", select: selectAction, andCancel: cancelAction)!;
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
        if isPakageSelect{
            return (self.TrainingSportDetailData?.packages?.count)!
        }
        else{
            return (self.TrainingSportDetailData?.sports?.count)!
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return NSString(format: "Row %lu", row) as String;
        if isPakageSelect{
            return self.TrainingSportDetailData?.packages![row].packageName
        }
        else{
            return self.TrainingSportDetailData?.sports![row].sportName
        }
        
    }
}

