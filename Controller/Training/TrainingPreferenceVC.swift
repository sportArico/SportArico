

import UIKit
import RMPickerViewController

class TrainingPreferenceVC: UIViewController {

    
    //MARK: Outlet
    @IBOutlet weak var btnBussiness: UIButton!
    @IBOutlet weak var txtSport: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var btnPersonal: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    //=== End ===//
    
    //MARK: Variable
    var ArraySportCategory:[SportCategoryData] = []
    var OnSave: ((_ Param: [String:String]) -> ())?
    var sport_id = ""
    var account_type = "company"
    var handicap = "1"
    //=== End ===//
    
    fileprivate func SetUpUI() {
        btnNo.layer.cornerRadius = btnNo.layer.frame.width / 2
        btnNo.clipsToBounds = true
        btnYes.layer.cornerRadius = btnYes.layer.frame.width / 2
        btnYes.clipsToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        txtLocation.text = AppDelegate.sharedDelegate().location_name
        self.APICallSportCategoryGet()
        btnNo(0 as Any)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBussiness(_ sender: Any) {
        btnBussiness.backgroundColor = UIColor.colorFromHex(hexString: "#2F4AEF")
        btnPersonal.backgroundColor = UIColor.clear
        btnBussiness.setTitleColor(UIColor.white, for: .normal)
        btnPersonal.setTitleColor(UIColor.gray, for: .normal)
        btnPersonal.layer.borderColor = UIColor.gray.cgColor
        btnPersonal.layer.borderWidth = 0.5
        self.account_type = "company"
    }
    @IBAction func btnPersonal(_ sender: Any) {
        btnBussiness.backgroundColor = UIColor.clear
        btnPersonal.backgroundColor = UIColor.colorFromHex(hexString: "#2F4AEF")
        btnPersonal.setTitleColor(UIColor.white, for: .normal)
        btnBussiness.setTitleColor(UIColor.gray, for: .normal)
        btnBussiness.layer.borderColor = UIColor.gray.cgColor
        btnBussiness.layer.borderWidth = 0.5
        self.account_type = "personal"
    }
    @IBAction func txtSport(_ sender: Any) {
        self.view.endEditing(true)
        if self.ArraySportCategory.count > 0{
            self.openPickerViewController()
        }
        else {
            Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
        }
    }
    @IBAction func btnSave(_ sender: Any) {
        let param:[String:String] = ["latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"sport_id":sport_id,"location":"","is_handicap":self.handicap,"user_id":(UserManager.shared.currentUser?.user_id)!,"search_text":AppDelegate.sharedDelegate().location_name]
        OnSave?(param)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnNo(_ sender: Any) {
        handicap = "0"
        btnNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
        btnYes.setImage(UIImage(named:""), for: .normal)
    }
    @IBAction func btnYes(_ sender: Any) {
        handicap = "1"
        btnNo.setImage(UIImage(named:""), for: .normal)
        btnYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
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

//MARK: API Calling...
extension TrainingPreferenceVC{
    func APICallSportCategoryGet(){
        CategoryManager.shared.GetSportCategory { (ArraySportData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArraySportData.count > 0{
                self.ArraySportCategory = ArraySportData as! [SportCategoryData]
                self.txtSport.text = self.ArraySportCategory[0].sportName
                self.sport_id = self.ArraySportCategory[0].sportId!
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
}
}
//MARK: PickerView Action and selection
extension TrainingPreferenceVC: UIPickerViewDelegate, UIPickerViewDataSource{
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
            self.txtSport.text = self.ArraySportCategory[selectedRows].sportName
            self.sport_id = self.ArraySportCategory[selectedRows].sportId!
            self.txtSport.resignFirstResponder()
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
        return self.ArraySportCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return NSString(format: "Row %lu", row) as String;
        return self.ArraySportCategory[row].sportName
    }
}
