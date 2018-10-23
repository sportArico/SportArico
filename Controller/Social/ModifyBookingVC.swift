

import UIKit
import RangeSeekSlider
import RMPickerViewController

class ModifyBookingVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var txtSportType: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var AgeRangeBar: RangeSeekSlider!
    @IBOutlet weak var DistanceRangeBar: RangeSeekSlider!
    // === End ==//
    
    
    //MARK: Variable
    var ArraySportCategory:[SportCategoryData] = []
    var OnSave: ((_ Param: [String:String]) -> ())?
    var distance = ""
    var max_price = ""
    var min_price = ""
    var sport_id = ""
    var Gender = "male"
    //=== End ===
    
    fileprivate func SetUpUI() {
        btnMale.layer.cornerRadius = btnMale.layer.frame.width / 2
        btnMale.clipsToBounds = true
        btnFemale.layer.cornerRadius = btnFemale.layer.frame.width / 2
        btnFemale.clipsToBounds = true
        AgeRangeBar.delegate = self
        DistanceRangeBar.delegate = self
        txtLocation.text = AppDelegate.sharedDelegate().location_name
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        self.APICallSportCategoryGet()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnFemale(_ sender: Any) {
        btnFemale.backgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
        btnMale.backgroundColor = UIColor.colorFromHex(hexString: "#EBEBF1")
        self.Gender = "female"
    }
    @IBAction func btnMale(_ sender: Any) {
        btnFemale.backgroundColor = UIColor.colorFromHex(hexString: "#EBEBF1")
        btnMale.backgroundColor = UIColor.colorFromHex(hexString: "#007AFF")
        self.Gender = "male"
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
    @IBAction func btnSaveChanges(_ sender: Any) {
        //,"age_range_end":"\(max_price)","age_range_start":"\(min_price)"
        let param = ["sport_id":sport_id,"latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"location":txtLocation.text!,"gender":self.Gender,"distance":"\(self.distance)","user_id":(UserManager.shared.currentUser?.user_id)!]
        OnSave?(param)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txtSportType(_ sender: Any) {
        self.view.endEditing(true)
        if self.ArraySportCategory.count > 0{
            self.openPickerViewController()
        }
        else {
            Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
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

// MARK: - RangeSeekSliderDelegate
extension ModifyBookingVC: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === AgeRangeBar {
            //print("Standard slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
            self.max_price = "\(Int(maxValue))"
            self.min_price = "\(Int(minValue))"
        } else if slider === DistanceRangeBar {
            //print("Currency slider updated. Min Value: \(minValue) Max Value: \(maxValue)")
            self.distance = "\(Int(maxValue))"
        }
    }
    
    func didStartTouches(in slider: RangeSeekSlider) {
        print("did start touches")
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        print("did end touches")
    }
}

//MARK: PickerView Action and selection
extension ModifyBookingVC: UIPickerViewDelegate, UIPickerViewDataSource{
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
            self.txtSportType.text = self.ArraySportCategory[selectedRows].sportName
            self.sport_id = self.ArraySportCategory[selectedRows].sportId!
            self.txtSportType.resignFirstResponder()
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
        return self.ArraySportCategory.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return NSString(format: "Row %lu", row) as String;
        return ArraySportCategory[row].sportName
    }
}
extension ModifyBookingVC{
    func APICallSportCategoryGet(){
        CategoryManager.shared.GetSportCategory { (ArraySportData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArraySportData.count > 0{
                self.ArraySportCategory = ArraySportData as! [SportCategoryData]
                self.txtSportType.text = self.ArraySportCategory[0].sportName
                self.sport_id = self.ArraySportCategory[0].sportId!
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
    }
}
