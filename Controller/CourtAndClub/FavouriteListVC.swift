

import UIKit
import KYDrawerController

class FavouriteListVC: UIViewController {
    
    @IBOutlet weak var tblFavouriteList: UITableView!
    
    var ArrayProductList:[MarketHomeProductList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.APICallGetCourtList(user_id: (UserManager.shared.currentUser?.user_id)!)
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

extension FavouriteListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ArrayProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarksListCell", for: indexPath) as! BookMarksListCell
        cell.lblName.text = self.ArrayProductList[indexPath.row].productTitle
        cell.lblPrice.text = "AED \(self.ArrayProductList[indexPath.row].productPrice ?? "")"
        for _ in self.ArrayProductList[indexPath.row].productImages!{
            cell.imgImage.sd_setImage(with: URL.init(string: self.ArrayProductList[indexPath.row].productImages![0].image ?? ""), completed: nil)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
}

//MARK: API Calling...
extension FavouriteListVC{
    func APICallGetCourtList(user_id: String) {
        MarketManager.shared.GetMarketFavouriteProductList(withID: user_id) { (FavouriteProductData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if FavouriteProductData.count > 0{
                self.ArrayProductList = FavouriteProductData as! [MarketHomeProductList]
                self.tblFavouriteList.delegate = self
                self.tblFavouriteList.dataSource = self
                self.tblFavouriteList.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
        }
    }
}

