

import UIKit
import KYDrawerController
import RangeSeekSlider
import RMPickerViewController

class CourtPreferenceVC: UIViewController{
    
    //MARK: Outlet
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var txtSportType: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var PriceRangeBar: RangeSeekSlider!
    @IBOutlet weak var DistanceRangeBar: RangeSeekSlider!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    //=== End ==//
    
    //MARK: Variable
    var drawer:KYDrawerController!
    var ArraySportCategory:[SportCategoryData] = []
    var OnSave: ((_ Param: [String:String]) -> ())?
    var distance = ""
    var max_price = ""
    var min_price = ""
    var sport_id = ""
    var handicap = "1"
    //=== End ==//

    fileprivate func SetUpUI() {
        btnNo.layer.cornerRadius = btnNo.layer.frame.width / 2
        btnNo.clipsToBounds = true
        btnYes.layer.cornerRadius = btnYes.layer.frame.width / 2
        btnYes.clipsToBounds = true
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpUI()
        PriceRangeBar.delegate = self
        DistanceRangeBar.delegate = self
        txtLocation.text = AppDelegate.sharedDelegate().location_name
        self.APICallSportCategoryGet()
        btnNo(0 as Any)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    //MARK: Button Action
    @IBAction func btnMenu(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    @IBAction func btnUser(_ sender: Any) {
        
    }
    
    @IBAction func btnSaveChanges(_ sender: Any) {
        let param = ["category_id":"1","sport_ids":"\(sport_id)","latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"distance":"\(self.distance)","price_range_end":"\(max_price)","price_range_start":"\(min_price)","is_handicap":self.handicap,"search_text":self.txtLocation.text!,"user_id":UserManager.shared.currentUser?.user_id,"location":""]
        OnSave?(param as! [String : String])
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
// MARK: - RangeSeekSliderDelegate
extension CourtPreferenceVC: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        if slider === PriceRangeBar {
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
extension CourtPreferenceVC: UIPickerViewDelegate, UIPickerViewDataSource{
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
extension CourtPreferenceVC{
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
