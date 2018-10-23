

import UIKit
import RMPickerViewController

class NewTeamVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var txtGroupTitle: UITextField!
    @IBOutlet weak var txtMaxSize: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtVenue: UITextField!
    @IBOutlet weak var btnmale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnPrivate: UIButton!
    @IBOutlet weak var btnNormal: UIButton!
    @IBOutlet weak var btnPublic: UIButton!
    @IBOutlet weak var btnSports: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnTime: UIButton!
    @IBOutlet weak var btnDes: UITextField!
    @IBOutlet weak var btnNotifyplayBall: UISwitch!
    // === End ===//
    
    //MARK: Variable
    var OnReload: ((_ ISReload: Bool) -> ())?
    var TempArraySportCategory:[SportCategoryData] = []
    var Sport_Id = ""
    
    
    var userLocation = ""
    var latitute = ""
    var longtitute = ""
    // === End === //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.APICallSportCategoryGet()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
    @IBAction func btnPublic(_ sender: Any) {
        
        btnNormal.backgroundColor = UIColor.clear
        btnPrivate.backgroundColor = UIColor.clear
        btnPublic.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 155.0/255.0, blue: 254.0/255.0, alpha: 1)
        
        btnPublic.accessibilityLabel = "1"
        btnNormal.accessibilityLabel = "0"
        btnPrivate.accessibilityLabel = "0"
        
        
//        btnNormal.isSelected = false
//        btnPrivate.isSelected = false
//        btnPublic.isSelected = true
        
        btnPublic.titleLabel?.textColor = .white
        btnPrivate.titleLabel?.textColor = .black
        btnNormal.titleLabel?.textColor = .black
    }
    
    @IBAction func btnNormal(_ sender: Any) {
        
        btnPublic.backgroundColor = UIColor.clear
        btnPrivate.backgroundColor = UIColor.clear
        btnNormal.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 155.0/255.0, blue: 254.0/255.0, alpha: 1)
        
        btnPublic.accessibilityLabel = "0"
        btnNormal.accessibilityLabel = "1"
        btnPrivate.accessibilityLabel = "0"
        
//        btnPublic.isSelected = false
//        btnPrivate.isSelected = false
//        btnNormal.isSelected = true
        
        btnPublic.titleLabel?.textColor = .black
        btnPrivate.titleLabel?.textColor = .black
        btnNormal.titleLabel?.textColor = .white
    }
    
    @IBAction func btnPrivate(_ sender: Any) {
        
        btnPublic.backgroundColor = UIColor.clear
        btnNormal.backgroundColor = UIColor.clear
        
        btnPrivate.backgroundColor = UIColor(displayP3Red: 30.0/255.0, green: 155.0/255.0, blue: 254.0/255.0, alpha: 1)
        
        btnPublic.accessibilityLabel = "0"
        btnNormal.accessibilityLabel = "0"
        btnPrivate.accessibilityLabel = "1"
        
        
//
//        btnPublic.isSelected = false
//        btnNormal.isSelected = false
//        btnPrivate.isSelected = true
        
        
        btnPublic.titleLabel?.textColor = .black
        btnPrivate.titleLabel?.textColor = .white
        btnNormal.titleLabel?.textColor = .black
    }
    
    @IBAction func btnmale(_ sender: Any) {
        btnmale.setImage(#imageLiteral(resourceName: "male1"), for: .normal)
        btnFemale.setImage(#imageLiteral(resourceName: "female (1)"), for: .normal)
    }
    @IBAction func btnFemale(_ sender: Any) {
        btnmale.setImage(#imageLiteral(resourceName: "male11"), for: .normal)
        btnFemale.setImage(#imageLiteral(resourceName: "female2"), for: .normal)
    }
    
    @IBAction func btnSports(_ sender: Any) {
        if self.TempArraySportCategory.count > 0{
            self.openPickerViewController()
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "no sport available.", controller: self)
        }
    }
    @IBAction func btnLocation(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "SearchLocationVC") as! SearchLocationVC
        
        VC.OnSave = { (Param) in
            print(Param)
            self.btnLocation.setTitle(Param["search_text"]!, for: .normal)
            self.latitute = Param["latitude"]!
            self.longtitute = Param["longitude"]!
        }
        
        self.navigationController?.pushViewController(VC, animated: true)
        
        //btnLocation.setTitle(AppDelegate.sharedDelegate().location_name, for: .normal)
    }
    @IBAction func btnDate(_ sender: Any) {
        let alert = UIAlertController(title: "Select Date", message: "", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            self.btnDate.setTitle(formatter.string(from: date), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in }
        alert.show()
    }
    @IBAction func btnTime(_ sender: Any) {
        let alert = UIAlertController(title: "Select Time", message: "", preferredStyle: .actionSheet)
        alert.addDatePicker(mode: .time, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter  = DateFormatter()
            formatter.dateFormat = "HH-mm-ss"
            self.btnTime.setTitle(formatter.string(from: date), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel, isEnabled: true) { (action:UIAlertAction!) in }
        alert.show()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        
        guard (txtGroupTitle.text  == "" ? nil : txtGroupTitle.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Group Title", controller: self)
            return
        }
        guard (txtMaxSize.text  == "" ? nil : txtMaxSize.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Max Size", controller: self)
            return
        }
        guard (txtPrice.text  == "" ? nil : txtPrice.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Price", controller: self)
            return
        }
        guard (btnSports.currentTitle  == "Select Sport" ? nil : btnSports.currentTitle) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Select Sport", controller: self)
            return
        }
        guard (btnLocation.currentTitle  == "Select Location" ? nil : btnLocation.currentTitle) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Select Location", controller: self)
            return
        }
        guard (btnDate.currentTitle  == "Select Date" ? nil : btnDate.currentTitle) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Select Date", controller: self)
            return
        }
        guard (btnTime.currentTitle  == "Select Time" ? nil : btnTime.currentTitle) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Select Time", controller: self)
            return
        }
        var gender = ""
        if btnmale.currentImage == #imageLiteral(resourceName: "male1"){
            gender = "male"
        }
        else{
            gender = "female"
        }
        
        guard (btnDes.text  == "" ? nil : btnDes.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Description", controller: self)
            return
        }
        var isNotify = "0"
        if btnNotifyplayBall.isOn{
            isNotify = "1"
        }
        
        var type = ""
        
        if btnPublic.accessibilityLabel == "1"
        {
            type = "public"
        }
        
        if btnPrivate.accessibilityLabel == "1"
        {
            type = "private"
        }
        
        if btnNormal.accessibilityLabel == "1"
        {
            type = "normal"
        }
        
        
        let param:[String:String] = ["user_id":(UserManager.shared.currentUser?.user_id)!,"group_title":txtGroupTitle.text!,"max_size":txtMaxSize.text!,"price":txtPrice.text!,"type":type,"description":btnDes.text!,"location":btnLocation.currentTitle!,"event_date":btnDate.currentTitle!,"event_time":btnTime.currentTitle!,"latitude":latitute,"longitude":longtitute,"gender":gender,"sport_id":self.Sport_Id,"venue":txtVenue.text!,"notify_playball":isNotify]
        print(param)
        self.APICallCreateGroup(param: param)
        
    }
  

}
extension NewTeamVC{
    func APICallCreateGroup(param: [String:String] = [:]) {
        SocialManager.shared.CreateGroup(param: param) { (isCreated, error) in
            if isCreated == true{
                let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.OnReload?(true)
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
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
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
    }
}

//MARK: PickerView Action and selection
extension NewTeamVC: UIPickerViewDelegate, UIPickerViewDataSource{
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
            self.btnSports.setTitle(self.TempArraySportCategory[selectedRows].sportName, for: .normal)
            self.Sport_Id = self.TempArraySportCategory[selectedRows].sportId!
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
