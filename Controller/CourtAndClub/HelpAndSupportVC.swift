

import UIKit

class HelpAndSupportVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var txtDetail: UITextView!
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SettingManager.shared.GetHelpAndSupport { (HelpAndSupportData, error) in
            if HelpAndSupportData != nil{
                self.txtDetail.text = HelpAndSupportData?.value(forKey: "text") as? String ?? ""
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
