

import UIKit

class MyPitchesVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var tblMyPitch: UITableView!
    @IBOutlet weak var btnAddNew: UIButton!
    //=== End ===//
    
    
    //MARK: Variable
    var ArrayMyPitchesList:[ListMyPitchData] = []
    var ArrayMarketCategory:[MarketCategoryData] = []
    var isReview = false
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isReview{
            btnAddNew.isHidden = true
        }
        else{
            btnAddNew.isHidden = false
        }
        
        tblMyPitch.register(UINib(nibName: "MyPitchesCell", bundle: nil), forCellReuseIdentifier: "MyPitchesCell")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        if UserManager.shared.currentUser?.category_id == "1" || UserManager.shared.currentUser?.category_id == "2"{
            self.APICallGetMyPitchesList(user_Id: (UserManager.shared.currentUser?.user_id)!)
        }
        else if UserManager.shared.currentUser?.category_id == "3"{
            self.APICallMarketCategoryGet(userID: (UserManager.shared.currentUser?.user_id)!)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddNew(_ sender: Any) {
        if UserManager.shared.currentUser?.category_id == "1"{
            let storyboard = UIStoryboard(name: "Provider", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "AddNewPitchesVC") as! AddNewPitchesVC
            navigationController?.pushViewController(VC, animated: true)
        }
        else if UserManager.shared.currentUser?.category_id == "2"{
            let storyboard = UIStoryboard(name: "Provider", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "AddCourseVC") as! AddCourseVC
            navigationController?.pushViewController(VC, animated: true)
        }
        else if UserManager.shared.currentUser?.category_id == "3"{
            let storyboard = UIStoryboard(name: "Provider", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "AddMarketCategoryVC") as! AddMarketCategoryVC
            navigationController?.pushViewController(VC, animated: true)
        }
        else{
            
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
extension MyPitchesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if UserManager.shared.currentUser?.category_id == "1"{
            return self.ArrayMyPitchesList.count
        }
        else if UserManager.shared.currentUser?.category_id == "2"{
            return self.ArrayMyPitchesList.count
        }
        else if UserManager.shared.currentUser?.category_id == "3"{
            return self.ArrayMarketCategory.count
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPitchesCell", for: indexPath) as? MyPitchesCell else {
            return UITableViewCell()
        }
        if(indexPath.row % 2 == 0){
            cell.lblColorShow.backgroundColor = UIColor.colorFromHex(hexString: "#DA55A1")
        }
        else{
            cell.lblColorShow.backgroundColor = UIColor.colorFromHex(hexString: "#0088FF")
        }
        if UserManager.shared.currentUser?.category_id == "1"{
            cell.lblName.text = self.ArrayMyPitchesList[indexPath.row].pitchName
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(MyPitchesVC.btnDelete(sender:)), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(MyPitchesVC.btnEdit(sender:)), for: .touchUpInside)
        }
        else if UserManager.shared.currentUser?.category_id == "2"{
            cell.lblName.text = self.ArrayMyPitchesList[indexPath.row].pitchName
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(MyPitchesVC.btnDelete(sender:)), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(MyPitchesVC.btnEdit(sender:)), for: .touchUpInside)
        }
        else if UserManager.shared.currentUser?.category_id == "3"{
            cell.lblName.text = self.ArrayMarketCategory[indexPath.row].mCatName
            cell.btnDelete.tag = indexPath.row
            cell.btnDelete.addTarget(self, action: #selector(MyPitchesVC.btnDelete(sender:)), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.row
            cell.btnEdit.addTarget(self, action: #selector(MyPitchesVC.btnEdit(sender:)), for: .touchUpInside)
        }
        if self.isReview{
            cell.btnEdit.isHidden = true
            cell.btnDelete.isHidden = true
        }
        else{
            cell.btnEdit.isHidden = false
            cell.btnDelete.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Provider", bundle: nil)
        if UserManager.shared.currentUser?.category_id == "3"{
            let VC = storyboard.instantiateViewController(withIdentifier: "ProviderMarketProductListVC") as! ProviderMarketProductListVC
            VC.M_Category_Id = self.ArrayMarketCategory[indexPath.row].mCatId!
            navigationController?.pushViewController(VC, animated: true)
        }
        else if isReview{
            let VC = storyboard.instantiateViewController(withIdentifier: "ProviderReviewVC") as! ProviderReviewVC
            VC.Court_ID = self.ArrayMyPitchesList[indexPath.row].id!
            navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    @objc func btnDelete(sender: UIButton){
        if UserManager.shared.currentUser?.category_id == "1"{
            ProviderManager.shared.DeleteProviderCourt(withID: (UserManager.shared.currentUser?.user_id)!, Court_Id: self.ArrayMyPitchesList[sender.tag].id!) { (isDelete, error) in
                if isDelete == true{
                    let alert = UIAlertController(title: "Success", message: "Court Delete Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                        self.ArrayMyPitchesList.remove(at: sender.tag)
                        self.tblMyPitch.reloadData()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            }
        }
        else if UserManager.shared.currentUser?.category_id == "2"{
            ProviderManager.shared.DeleteProviderCources(withID: (UserManager.shared.currentUser?.user_id)!, Cources_ID: self.ArrayMyPitchesList[sender.tag].id!, completion: { (isDelete, error) in
                if isDelete == true{
                    let alert = UIAlertController(title: "Success", message: "Cources Delete Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                        self.ArrayMyPitchesList.remove(at: sender.tag)
                        self.tblMyPitch.reloadData()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            })
        }
        else if UserManager.shared.currentUser?.category_id == "3"{
            
            ProviderManager.shared.DeleteProviderMarketCategory(withID: (UserManager.shared.currentUser?.user_id)!, M_Cat_Id: self.ArrayMarketCategory[sender.tag].mCatId!, completion: { (isDelete, error) in
                if isDelete == true{
                    let alert = UIAlertController(title: "Success", message: "Market Category Delete Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                        self.ArrayMarketCategory.remove(at: sender.tag)
                        self.tblMyPitch.reloadData()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    Utility.setAlertWith(title: "Error", message: error, controller: self)
                }
            })
        }
        
    }
    @objc func btnEdit(sender: UIButton){
        if UserManager.shared.currentUser?.category_id == "1"{
            let storyboard = UIStoryboard(name: "Provider", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "AddNewPitchesVC") as! AddNewPitchesVC
            VC.isEdit = true
            VC.CourtID = self.ArrayMyPitchesList[sender.tag].id!
            navigationController?.pushViewController(VC, animated: true)
        }
        else if UserManager.shared.currentUser?.category_id == "2"{
            let storyboard = UIStoryboard(name: "Provider", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "AddCourseVC") as! AddCourseVC
            VC.isEdit = true
            VC.Cources_ID = self.ArrayMyPitchesList[sender.tag].id!
            navigationController?.pushViewController(VC, animated: true)
        }
        else if UserManager.shared.currentUser?.category_id == "3"{
            let storyboard = UIStoryboard(name: "Provider", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "AddMarketCategoryVC") as! AddMarketCategoryVC
            VC.IsEdit = true
            VC.ArrayMarketCategoryDetail = self.ArrayMarketCategory[sender.tag]
            navigationController?.pushViewController(VC, animated: true)
        }
        else{
            
        }
    }
}
//MARK: API Calling...
extension MyPitchesVC{
    func APICallGetMyPitchesList(user_Id: String){
        ProviderManager.shared.GetMyPitchesList(UserId: user_Id) { (ArrayMyPitchesData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayMyPitchesData.count > 0{
                self.ArrayMyPitchesList = ArrayMyPitchesData as! [ListMyPitchData]
                self.tblMyPitch.delegate = self
                self.tblMyPitch.dataSource = self
                self.tblMyPitch.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
        }
    }
    
    func APICallMarketCategoryGet(userID: String){
        ProviderManager.shared.GetMarketCategory(withID: userID) { (ArrayMarketData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayMarketData.count > 0{
                self.ArrayMarketCategory = ArrayMarketData as! [MarketCategoryData]
                self.tblMyPitch.delegate = self
                self.tblMyPitch.dataSource = self
                self.tblMyPitch.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
    }
    
    
}
