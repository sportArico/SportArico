

import UIKit

class AddMarketCategoryVC: UIViewController {

    
    //MARK: Outlet
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDes: UITextField!
    //=== End ===//
    
    //MARK: Variable
    var isActive = "1"
    var IsEdit = false
    var ArrayMarketCategoryDetail:MarketCategoryData?
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
        if IsEdit{
            txtName.text = ArrayMarketCategoryDetail?.mCatName
            txtDes.text = ArrayMarketCategoryDetail?.mCatSlug
            self.isActive = (ArrayMarketCategoryDetail?.isActive)!
            if ArrayMarketCategoryDetail?.isActive == "1"{
                btnNo.setImage(UIImage(named:""), for: .normal)
                btnYes.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
            }
            else{
                btnNo.setImage(#imageLiteral(resourceName: "radio"), for: .normal)
                btnYes.setImage(UIImage(named:""), for: .normal)
            }
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

    @IBAction func btnSave(_ sender: Any) {
        guard (txtName.text  == "" ? nil : txtName.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Name", controller: self)
            return
        }
        guard (txtDes.text  == "" ? nil : txtDes.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter valid Description", controller: self)
            return
        }
        if IsEdit{
            self.APICallAddCategory(userID: (UserManager.shared.currentUser?.user_id)!, M_Ca_Name: txtName.text!, M_Ca_Slug: txtDes.text!, IsActive: self.isActive, IsEdit: true, M_Cat_Id: (self.ArrayMarketCategoryDetail?.mCatId)!)
        }
        else{
            self.APICallAddCategory(userID: (UserManager.shared.currentUser?.user_id)!, M_Ca_Name: txtName.text!, M_Ca_Slug: txtDes.text!, IsActive: self.isActive, IsEdit: false)
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
extension AddMarketCategoryVC{
    func APICallAddCategory(userID: String,M_Ca_Name: String,M_Ca_Slug: String,IsActive: String,IsEdit: Bool,M_Cat_Id: String = "") {
        ProviderManager.shared.AddMarketCategory(withID: userID, M_Cat_Name: M_Ca_Name, M_Cat_Slug: M_Ca_Slug, Is_Active: IsActive, isEdit: IsEdit,M_Cat_Id: M_Cat_Id) { (isAdded, error) in
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
}
