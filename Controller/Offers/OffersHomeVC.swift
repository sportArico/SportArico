

import UIKit
import KYDrawerController
import SDWebImage
import DropDown
class OffersHomeVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tblOffers: UITableView!
    @IBOutlet weak var colOffer: UICollectionView!
    @IBOutlet weak var lblLocationName: UILabel!
    //=== End ===//
    
    var categoryDrop:DropDown!
    @IBOutlet weak var cateName: UILabel!
    @IBOutlet weak var cateSelectAerrow: UIImageView!
    @IBOutlet weak var cateShowButton: UIButton!
    
    
    
    //MARK: Variable
    var ArrayOffersList:[OffersData] = []
    //=== End ===//

    override func viewDidLoad() {
        super.viewDidLoad()

        categoryDrop = DropDown()
        categoryDrop.dataSource = ["Court Offers", "Market Offers", "Cources Offers"]
        
        categoryDrop.selectionAction = { [unowned self] (index: Int, item: String) in
            self.APICallOffersGet(Category_id: "\(index + 1)")
            self.cateShowButton.isSelected = false
            self.cateName.text = item
        }
        
        categoryDrop.direction = .bottom
        categoryDrop.anchorView = cateShowButton
        categoryDrop.bottomOffset = CGPoint(x: 0, y:(categoryDrop.anchorView?.plainView.bounds.height)!)

        tblOffers.register(UINib(nibName: "OfferListCell", bundle: nil), forCellReuseIdentifier: "OfferListCell")
        tblOffers.register(UINib(nibName: "OffersHomeCell", bundle: nil), forCellReuseIdentifier: "OffersHomeCell")
        self.APICallOffersGet(Category_id: "1")
        colOffer.delegate = self
        colOffer.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lblLocationName.text = AppDelegate.sharedDelegate().location_name
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    
    @IBAction func btnFillter(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Training", bundle: nil)
//        let ivc = storyboard.instantiateViewController(withIdentifier: "TrainingPreferenceVC") as! TrainingPreferenceVC
//        navigationController?.pushViewController(ivc, animated: true)
    }
    
    @IBAction func btnCategory(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "ChangeCategoryVC") as! ChangeCategoryVC
        ivc.modalPresentationStyle = .overCurrentContext
        ivc.modalTransitionStyle = .coverVertical
        self.present(ivc, animated: true, completion: nil)
    }

    @IBAction func btnChangeLocation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "SearchLocationVC") as! SearchLocationVC
        ivc.OnSave = { (Param) in
            print(Param)
            //let param = ["sport_id":"","latitude":Param["latitude"]!,"longitude":Param["longitude"]!,"location":"","is_handicap":"","search_text":Param["search_text"]!,"user_id":UserManager.shared.currentUser?.user_id]
            self.APICallOffersGet(Category_id: "1")
        }
        navigationController?.pushViewController(ivc, animated: true)
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    
    // MARK: - Drop downlist
    
    @IBAction func onshowDropDown(_ sender: UIButton) {
        
        if !sender.isSelected
        {
            categoryDrop.show()
            sender.isSelected = true
        }
        else
        {
            categoryDrop.hide()
            sender.isSelected = false
        }
    }

}

extension OffersHomeVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.ArrayOffersList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OfferCell", for: indexPath) as? OfferCell else{
            return UICollectionViewCell()
        }
        cell.lblOffer.text = "\(self.ArrayOffersList[indexPath.row].offerTitle ?? "Flash sale")"
        cell.lbldesc.text = "\(self.ArrayOffersList[indexPath.row].descriptionField ?? "")"
        
        if let percentage = self.ArrayOffersList[indexPath.row].discount as? String
        {
            let perInt:Float? = Float(percentage)
            if let finalPer = perInt
            {
                cell.lblPercentage.text = "\(Int(finalPer))%"
            }
        }
        
        if let valid = self.ArrayOffersList[indexPath.row].validTo as? String
        {
            let toDate = valid.getDateFromStringWith(format: "YYYY-MM-dd")
            
            let currDate = Date().localDateString()
            
            var days = 0;
            var hour = 0;
            if let day = toDate?.days(from: currDate!)
            {
                days = day
            }
            
            if let hourV = toDate?.hours(from: currDate!)
            {
                hour = hourV  - (days * 24)
            }
            
            var dayText = "day"
            if days > 1
            {
                dayText = "days"
            }
            
            cell.lblTimeRemain.text = "\(days)\(dayText), \(hour)h Remaining"
        }
        
        cell.imgOffer.sd_setImage(with: URL(string: "\(self.ArrayOffersList[indexPath.row].image ?? "")"), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height:CGFloat = 200;
        var gap:CGFloat = 40
        if deviceType == .iPhone5_Se || deviceType == .iPhone4
        {
            height = 163;
            gap = 40
        }
        return CGSize(width: (self.view.frame.width - gap) / 2, height: height)
    }
    
    
    
}


extension OffersHomeVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.ArrayOffersList.count == 0 {
            self.tblOffers.setEmptyMessage("No offers found for selected criteria")
        } else {
            self.tblOffers.restore()
        }
        return self.ArrayOffersList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.ArrayOffersList[section].opened == true
        {
            return 2
        }
        else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataindex = indexPath.row - 1
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfferListCell", for: indexPath) as? OfferListCell else{
                return UITableViewCell()
            }
            cell.lblName.text = "\(self.ArrayOffersList[indexPath.row].discount ?? "")% DISCOUNT ON BOOKING"
//            if self.ArrayOffersList[indexPath.row].opened{
//                cell.imgBottomAarow.image = #imageLiteral(resourceName: "down-arrow")
//            }
//            else{
//                cell.imgBottomAarow.image = #imageLiteral(resourceName: "up-arrow")
//            }
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OffersHomeCell", for: indexPath) as? OffersHomeCell else{
                return UITableViewCell()
            }
            cell.imgImage.sd_setImage(with: URL.init(string: self.ArrayOffersList[dataindex].image!), completed: nil)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 45.0
        }
        else{
            return 200.0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.ArrayOffersList[indexPath.section].opened == true{
            self.ArrayOffersList[indexPath.section].opened = false
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfferListCell", for: indexPath) as? OfferListCell else{
                return
            }
            cell.imgBottomAarow.image = #imageLiteral(resourceName: "down-arrow")
            let section = IndexSet.init(integer: indexPath.section)
            tblOffers.reloadSections(section, with: .none)
        }
        else{
            self.ArrayOffersList[indexPath.section].opened = true
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfferListCell", for: indexPath) as? OfferListCell else{
                return
            }
            cell.imgBottomAarow.image = #imageLiteral(resourceName: "up-arrow")
            let section = IndexSet.init(integer: indexPath.section)
            tblOffers.reloadSections(section, with: .none)
        }
        
//        for i in 0..<self.ArrayOffersList.count{
//            if self.ArrayOffersList[i].opened == true{
//                self.ArrayOffersList[i].opened = false
//            }
//            else{
//                self.ArrayOffersList[i].opened = true
//            }
//        }
//        self.tblOffers.reloadData()
    }
    
}
//MARK: API Calling...
extension OffersHomeVC{
    func APICallOffersGet(Category_id: String) {
        OffersManager.shared.GetOffersList(withID: Category_id) { (OffersListData, error) in
            self.tblOffers.delegate = self
            self.tblOffers.dataSource = self
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
                //self.tblOffers.reloadData()
                self.colOffer.reloadData()
            }
            else if OffersListData.count > 0{
                self.ArrayOffersList = OffersListData as! [OffersData]
//                for i in 0..<self.ArrayOffersList.count{
//                    if(i % 2 == 0){
//                        self.ArrayOffersList[i].opened = true
//                    }
//                    else{
//                        self.ArrayOffersList[i].opened = false
//                    }
//                }
                print(self.ArrayOffersList.count)
                self.colOffer.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
                self.colOffer.reloadData()
            }
        }
    }
}



class OfferCell:UICollectionViewCell
{
    
    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var lbldesc: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var lblTimeRemain: UILabel!
    
}

extension String
{
    
    func getDateFromStringWith(format:String) -> Date? {
        
        let dateFmt = DateFormatter()
        dateFmt.timeZone = TimeZone(abbreviation: "GMT+0:00")
        dateFmt.dateFormat =  format
        // Get NSDate for the given string
        return dateFmt.date(from: self)
    }
}


extension Date
{
    
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }


    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        return ""
    }
    
    func addDaystoGivenDate(NumberOfDaysToAdd:Int)->Date
    {
        let dateComponents = NSDateComponents()
        let CurrentCalendar = NSCalendar.current
        let CalendarOption = NSCalendar.Options()
        
        dateComponents.day = NumberOfDaysToAdd
        let newDate = CurrentCalendar.date(byAdding: dateComponents as DateComponents, to: self)
        return newDate!
    }
    
  
    
    func localDateString(format:String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let dateStr =  dateFormatter.string(from: self)
        return dateFormatter.date(from:dateStr)
    }
    
}



