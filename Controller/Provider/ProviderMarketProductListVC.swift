

import UIKit

class ProviderMarketProductListVC: UIViewController {
    
    
    //MARK: Outlet
    @IBOutlet weak var tblMyMarketProduct: UITableView!
    //=== End ===//
    
    
    //MARK: Variable
    var M_Category_Id = ""
    var ArrayMyMarketProductList:[ProviderMarketProductData] = []
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblMyMarketProduct.register(UINib(nibName: "MyPitchesCell", bundle: nil), forCellReuseIdentifier: "MyPitchesCell")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool){
        self.APICallMarketCategoryGet(category_id: self.M_Category_Id)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnAddNew(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Provider", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "AddNewMarketVC") as! AddNewMarketVC
        VC.M_Cat_ID = self.M_Category_Id
        navigationController?.pushViewController(VC, animated: true)
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
extension ProviderMarketProductListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrayMyMarketProductList.count
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
        
        cell.lblName.text = self.ArrayMyMarketProductList[indexPath.row].productTitle
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(MyPitchesVC.btnDelete(sender:)), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(MyPitchesVC.btnEdit(sender:)), for: .touchUpInside)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
    }
    
    @objc func btnDelete(sender: UIButton){
        //Delete Market Product...
        ProviderManager.shared.DeleteProviderMarket(withID: (UserManager.shared.currentUser?.user_id)!, MProductId: self.ArrayMyMarketProductList[sender.tag].mProductId!, completion: { (isDelete, error) in
            if isDelete == true{
                let alert = UIAlertController(title: "Success", message: "Market Product Delete Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                    self.ArrayMyMarketProductList.remove(at: sender.tag)
                    self.tblMyMarketProduct.reloadData()
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        })
    }
    @objc func btnEdit(sender: UIButton){
        let storyboard = UIStoryboard(name: "Provider", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "AddNewMarketVC") as! AddNewMarketVC
        VC.isEdit = true
        VC.M_Cat_ID = self.ArrayMyMarketProductList[sender.tag].mCatId!
        VC.M_Product_Id = self.ArrayMyMarketProductList[sender.tag].mProductId!
        navigationController?.pushViewController(VC, animated: true)
    }
    
}
//MARK: API Calling...
extension ProviderMarketProductListVC{
    func APICallMarketCategoryGet(category_id: String){
        ProviderManager.shared.GetMarketProductByCategory(withID: category_id) { (ArrayMarketProductData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayMarketProductData.count > 0{
                self.ArrayMyMarketProductList = ArrayMarketProductData as! [ProviderMarketProductData]
                self.tblMyMarketProduct.delegate = self
                self.tblMyMarketProduct.dataSource = self
                self.tblMyMarketProduct.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no market product available", controller: self)
            }
        }
    }
    
}

