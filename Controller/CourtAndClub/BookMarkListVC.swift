

import UIKit
import KYDrawerController

class BookMarkListVC: UIViewController {

    @IBOutlet weak var tblBookmarkList: UITableView!
    
    var ArrayCourtList:[CourtHomeData] = []
    var ArrayCourcesList:[TrainingHomeData] = []
    var selectedCategory = UserDefaults.standard.value(forKey: "Category") as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if selectedCategory == "CourtAndClub"{
            let param:[String:String] = ["user_id":(UserManager.shared.currentUser?.user_id)!,"category_id":"1"]
            self.APICallGetCourtList(Param: param)
        }
        else if selectedCategory == "Social"{
        }
        else if selectedCategory == "Market"{
        }
        else if selectedCategory == "Courses"{
            let param:[String:String] = ["user_id":(UserManager.shared.currentUser?.user_id)!,"category_id":"2"]
            self.APICallGetCourcesList(Param: param)
        }
        else if selectedCategory == "Offers"{
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

extension BookMarkListVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCategory == "CourtAndClub"{
            return self.ArrayCourtList.count
        }
        else if selectedCategory == "Courses"{
            return self.ArrayCourcesList.count
        }
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookMarksListCell", for: indexPath) as! BookMarksListCell
        
        if selectedCategory == "CourtAndClub"{
            cell.lblName.text = self.ArrayCourtList[indexPath.row].courtTitle
            cell.lblPrice.text = "AED \(self.ArrayCourtList[indexPath.row].price ?? "")"
            cell.imgImage.sd_setImage(with: URL.init(string: self.ArrayCourtList[indexPath.row].courtImage ?? ""), completed: nil)
        }
        else if selectedCategory == "Courses"{
            cell.lblName.text = self.ArrayCourcesList[indexPath.row].courseTitle
            cell.lblPrice.text = "AED \(self.ArrayCourcesList[indexPath.row].sportToolsPrice ?? "")"
            cell.imgImage.sd_setImage(with: URL.init(string: self.ArrayCourcesList[indexPath.row].icon ?? ""), completed: nil)
        }
        else{
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    
}

//MARK: API Calling...
extension BookMarkListVC{
    func APICallGetCourtList(Param: [String:String]) {
        CourtAndClubManager.shared.GetBookMarksList(Param: Param) { (CourtListData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if CourtListData.count > 0{
                self.ArrayCourtList = CourtListData as! [CourtHomeData]
                self.tblBookmarkList.delegate = self
                self.tblBookmarkList.dataSource = self
                self.tblBookmarkList.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
        }
    }
    
    func APICallGetCourcesList(Param: [String:String]) {
        TrainingManager.shared.GetBookmarkList(param: Param) { (CourcesListData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if CourcesListData.count > 0{
                self.ArrayCourcesList = CourcesListData as! [TrainingHomeData]
                self.tblBookmarkList.delegate = self
                self.tblBookmarkList.dataSource = self
                self.tblBookmarkList.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
            }
        }
    }
}
