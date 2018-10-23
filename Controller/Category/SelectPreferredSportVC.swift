

import UIKit
import KYDrawerController
import SDWebImage

class SelectPreferredSportVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var ColView: UICollectionView!
    //=== End == //

    //MARK: Variable
    var ArraySportCategory:[SportCategoryData] = []
    var ArrayMarketCategory:[MarketCategoryData] = []
    var drawerController:KYDrawerController!
    var type = UserDefaults.standard.value(forKey: "Category") as! String
    //=== End == //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if type == "CourtAndClub"{
            self.APICallSportCategoryGet()
        }
        else if type == "Market"{
            self.APICallMarketCategoryGet()
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
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func btnSave(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "IsSelectPreSport")
        ChangeCategoryClass.shared.OpenCourtVC()
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
extension SelectPreferredSportVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}
extension SelectPreferredSportVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if type == "CourtAndClub"{
            return ArraySportCategory.count
        }
        else if type == "Market"{
            return ArrayMarketCategory.count
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectPreferredSportsCell", for: indexPath) as! SelectPreferredSportsCell
        if type == "CourtAndClub"{
            let objcourt = ArraySportCategory[indexPath.row]
            cell.lblName.text = objcourt.sportName
            cell.imgImages.sd_setImage(with: URL.init(string: objcourt.sportImage!), completed: nil)
            cell.imgImages.contentMode = .scaleAspectFill
            cell.imgImages.clipsToBounds = true
            if ArraySportCategory[indexPath.row].isSelected{
                cell.btnSelected.isHidden = false
            }
            else{
                cell.btnSelected.isHidden = true
            }
        }
        else if type == "Market"{
            let objmarket = ArrayMarketCategory[indexPath.row]
            cell.lblName.text = objmarket.mCatName
            cell.imgImages.sd_setImage(with: URL.init(string: objmarket.image!), completed: nil)
            cell.imgImages.contentMode = .scaleAspectFill
            cell.imgImages.clipsToBounds = true
            if ArrayMarketCategory[indexPath.row].isSelected{
                cell.btnSelected.isHidden = false
            }
            else{
                cell.btnSelected.isHidden = true
            }
        }
        else{
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if type == "CourtAndClub"{
            if self.ArraySportCategory[indexPath.row].isSelected{
                self.ArraySportCategory[indexPath.row].isSelected = false
                self.ColView.reloadData()
            }
            else{
                self.ArraySportCategory[indexPath.row].isSelected = true
                self.ColView.reloadData()
            }
        }
        else if type == "Market"{
            
            if self.ArrayMarketCategory[indexPath.row].isSelected{
                self.ArrayMarketCategory[indexPath.row].isSelected = false
                self.ColView.reloadData()
            }
            else{
                self.ArrayMarketCategory[indexPath.row].isSelected = true
                self.ColView.reloadData()
            }
        }
        else{
            
        }
    }
}
//MARK: SideMenu SetUp
extension SelectPreferredSportVC{
    
}

//MARK: API Calling...
extension SelectPreferredSportVC{
    func APICallSportCategoryGet(){
        CategoryManager.shared.GetSportCategory { (ArraySportData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArraySportData.count > 0{
                self.ArraySportCategory = ArraySportData as! [SportCategoryData]
                self.ColView.delegate = self
                self.ColView.dataSource = self
                self.ColView.reloadData()
            }
            else{
                 Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
    }
    
    func APICallMarketCategoryGet(){
        CategoryManager.shared.GetMarketCategory { (ArrayMarketData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayMarketData.count > 0{
                self.ArrayMarketCategory = ArrayMarketData as! [MarketCategoryData]
                self.ColView.delegate = self
                self.ColView.dataSource = self
                self.ColView.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no market category available", controller: self)
            }
        }
    }
}
