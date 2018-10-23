

import UIKit

class BookNowVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var SelectSportCollectionView: UICollectionView!
    @IBOutlet weak var SelectDateCollectionView: UICollectionView!
    @IBOutlet weak var SelectTimeCollectionView: UICollectionView!
    //=== End ===//
    
    //MARK: Variable
    var ArraySportCategory:[SportCategoryData] = []
    var ArrayBookAvailable:[BookAvailableTimeData] = []
    var isSelecteCell = 0
    var CourtDetailData:CourtDetailData?
    var book_avail_timeIds:[String] = []
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.APICallSportCategoryGet()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        for i in 0..<self.ArrayBookAvailable.count{
            if self.ArrayBookAvailable[i].isSelected{
                for j in 0..<self.ArrayBookAvailable[i].availableTime!.count{
                    if self.ArrayBookAvailable[i].availableTime![j].isSelected{
                        self.book_avail_timeIds.append(self.ArrayBookAvailable[i].availableTime![j].bookAvailId!)
                    }
                }
            }
        }
        if self.book_avail_timeIds.count > 0 {
            
        }
        else{
            Utility.setAlertWith(title: "Alert", message: "Please select one time to continue process...", controller: self)
            return
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProceedToPayVC") as! ProceedToPayVC
        vc.CourtDetailData = self.CourtDetailData
        vc.book_avail_timeIds = self.book_avail_timeIds
        navigationController?.pushViewController(vc, animated: true)
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


extension BookNowVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == SelectSportCollectionView{
            return self.ArraySportCategory.count
        }
        else if collectionView == SelectDateCollectionView{
            return self.ArrayBookAvailable.count
        }
        else if collectionView == SelectTimeCollectionView{
            if self.ArrayBookAvailable.count > 0{
                return (self.ArrayBookAvailable[self.isSelecteCell].availableTime?.count)!
            }
            else{
                return 0
            }
        }
        else{
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == SelectSportCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectSportCell", for: indexPath) as? SelectSportCell else {
                return UICollectionViewCell()
            }
            
            cell.imgImages.sd_setImage(with: URL.init(string: self.ArraySportCategory[indexPath.row].sportIcon ?? ""), completed: nil)
            cell.imgImages.image = cell.imgImages.image?.withRenderingMode(.alwaysTemplate)
            cell.lblName.text = self.ArraySportCategory[indexPath.row].sportName
            if (self.ArraySportCategory[indexPath.row].isSelected){
                cell.imgImages.tintColor = UIColor.colorFromHex(hexString: "#6389FD")
                cell.lblName.textColor = UIColor.colorFromHex(hexString: "#6389FD")
            }
            else{
                cell.imgImages.tintColor = UIColor.black
                cell.lblName.textColor = UIColor.black
            }
            return cell
        }
        else if collectionView == SelectDateCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectBookDateCell", for: indexPath) as? SelectBookDateCell else {
                return UICollectionViewCell()
            }
            cell.lblName.cornerRadius = 5
            cell.lblName.clipsToBounds = true
            cell.lblName.text = "\(GetFormatedDate(From: "yyyy-MM-dd", To: "dd-MMM", Value: self.ArrayBookAvailable[indexPath.row].bookAvailDate ?? "") ?? "")"
            if (self.ArrayBookAvailable[indexPath.row].isSelected){
                cell.lblName.backgroundColor = UIColor.colorFromHex(hexString: "#6389FD")
                cell.lblName.textColor = UIColor.white
            }
            else{
                cell.lblName.backgroundColor = UIColor.clear
                cell.lblName.textColor = UIColor.black
            }
            return cell
        }
        else if collectionView == SelectTimeCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectBookTimeCell", for: indexPath) as? SelectBookTimeCell else {
                return UICollectionViewCell()
            }
            cell.lblName.text = getTimeString(self.ArrayBookAvailable[isSelecteCell].availableTime![indexPath.row].bookAvailTime ?? "") ?? ""
            cell.lblName.cornerRadius = 5
            cell.lblName.clipsToBounds = true
            if (self.ArrayBookAvailable[isSelecteCell].availableTime![indexPath.row].isSelected){
                cell.lblName.backgroundColor = UIColor.colorFromHex(hexString: "#6389FD")
                cell.lblName.textColor = UIColor.white
            }
            else{
                cell.lblName.backgroundColor = UIColor.clear
                cell.lblName.textColor = UIColor.black
            }
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        if collectionView == SelectSportCollectionView{
            return CGSize(width: 50, height: 65)
        }
        else if collectionView == SelectDateCollectionView{
            return CGSize(width: 60, height:30)
        }
        else if collectionView == SelectTimeCollectionView{
            return CGSize(width: 100, height: 30)
        }
        else{
            return CGSize(width: 0, height: 0)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == SelectSportCollectionView{
            for i in 0..<self.ArraySportCategory.count{
                self.ArraySportCategory[i].isSelected = false
            }
            self.ArraySportCategory[indexPath.row].isSelected = true
            self.SelectSportCollectionView.reloadData()
        }
        else if collectionView == SelectDateCollectionView{
            for i in 0..<self.ArrayBookAvailable.count{
                self.ArrayBookAvailable[i].isSelected = false
            }
            self.ArrayBookAvailable[indexPath.row].isSelected = true
            self.isSelecteCell = indexPath.row
            self.SelectDateCollectionView.reloadData()
            self.SelectTimeCollectionView.reloadData()
        }
        else if collectionView == SelectTimeCollectionView{
//            for i in 0..<self.ArrayBookAvailable[self.isSelecteCell].availableTime!.count{
//                self.ArrayBookAvailable[self.isSelecteCell].availableTime![i].isSelected = false
//            }
            if self.ArrayBookAvailable[self.isSelecteCell].availableTime![indexPath.row].isSelected{
                self.ArrayBookAvailable[self.isSelecteCell].availableTime![indexPath.row].isSelected = false
            }
            else{
                self.ArrayBookAvailable[self.isSelecteCell].availableTime![indexPath.row].isSelected = true
            }
            //self.isSelecteCell = indexPath.row
            self.SelectTimeCollectionView.reloadData()
        }
        else{
            
        }
    }
    //    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    //        if collectionView == DateSelectCollectionview{
    //            collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.clear
    //        }
    //    }
    
}
//MARK: API Calling...
extension BookNowVC{
    func APICallSportCategoryGet(){
        CategoryManager.shared.GetSportCategory { (ArraySportData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArraySportData.count > 0{
                self.ArraySportCategory = ArraySportData as! [SportCategoryData]
                for i in 0..<self.ArraySportCategory.count{
                    self.ArraySportCategory[i].isSelected = true
                    break
                }
                self.SelectSportCollectionView.delegate = self
                self.SelectSportCollectionView.dataSource = self
                self.SelectSportCollectionView.reloadData()
                self.APICallGetBookAvailableTime(Court_Id: (self.CourtDetailData?.courtId)!, User_Id: (UserManager.shared.currentUser?.user_id)!, Type: "court")
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
    }
    func APICallGetBookAvailableTime(Court_Id: String,User_Id: String,Type: String) {
        CourtAndClubManager.shared.GetBookAvailable(withID: Court_Id, User_Id: User_Id, Type: Type) { (ArrayBookAvailableData, error) in
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
            else if ArrayBookAvailableData.count > 0 && ArrayBookAvailableData != nil{
                self.ArrayBookAvailable = ArrayBookAvailableData as! [BookAvailableTimeData]
                for i in 0..<self.ArrayBookAvailable.count{
                    self.ArrayBookAvailable[i].isSelected = true
                    for i in 0..<self.ArrayBookAvailable[i].availableTime!.count{
                        self.ArrayBookAvailable[i].availableTime![i].isSelected = true
                        break
                    }
                    break
                }
                self.SelectDateCollectionView.delegate = self
                self.SelectDateCollectionView.dataSource = self
                self.SelectDateCollectionView.reloadData()
                
                
                self.SelectTimeCollectionView.delegate = self
                self.SelectTimeCollectionView.dataSource = self
                self.SelectTimeCollectionView.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no sport available", controller: self)
            }
        }
    }
    
}
