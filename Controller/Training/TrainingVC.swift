

import UIKit
import KYDrawerController

class TrainingVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var tblCources: UITableView!
    @IBOutlet weak var lblLocationName: UILabel!
    //=== End ===//
    
    
    //MARK: Variable
    var section = ["Recommended"]
    var ArrayTrainingDataList:[TrainingHomeData] = []
    var ArraySport:[TrainingHomeSport] = []
    //=== End == //

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let param:[String:String] = ["latitude":AppDelegate.sharedDelegate().userLatitude,"longitude":AppDelegate.sharedDelegate().userLongitude,"sport_id":"","location":AppDelegate.sharedDelegate().location_name,"account_type":""]
        
        self.APICallMarketProductList(param: param)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.lblLocationName.text = AppDelegate.sharedDelegate().location_name
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        if let drawerController = navigationController?.parent as? KYDrawerController {
            drawerController.setDrawerState(.opened, animated: true)
        }
    }
    @IBAction func btnChangeLocation(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "SearchLocationVC") as! SearchLocationVC
            ivc.OnSave = { (Param) in
                print(Param)
                let param = ["sport_id":"","latitude":Param["latitude"]!,"longitude":Param["longitude"]!,"location":"","is_handicap":"","search_text":Param["search_text"]!,"user_id":UserManager.shared.currentUser?.user_id]
                self.APICallMarketProductList(param: param as! [String : String])
        }
        navigationController?.pushViewController(ivc, animated: true)
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
    
    @IBAction func btnNotification(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TrainingFiltter"{
            let popview = segue.destination as! TrainingPreferenceVC
            popview.OnSave = { (Param) in
                print(Param)
                self.APICallMarketProductList(param: Param)
            }
        }
        
    }

}
extension TrainingVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.ArrayTrainingDataList.count == 0 {
            self.tblCources.setEmptyMessage("No cources found for selected criteria")
        } else {
            self.tblCources.restore()
        }
        return self.ArrayTrainingDataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "CourcesCell", for: indexPath) as? CourcesCell else{
        return UITableViewCell() }
        cell.imgImage.sd_setImage(with: URL.init(string: self.ArrayTrainingDataList[indexPath.row].icon!), completed: nil)
        cell.lblName.text = self.ArrayTrainingDataList[indexPath.row].courseTitle
        cell.lblAddress.text = "\(self.ArrayTrainingDataList[indexPath.row].location ?? "") (\(Int(self.ArrayTrainingDataList[indexPath.row].distance ?? 0.0)) km)"
        if self.ArrayTrainingDataList[indexPath.row].isRecommended == "1"{
            cell.lblRecommendedLine.isHidden = false
            cell.imgRightArrow.isHidden = false
        }
        else{
            cell.lblRecommendedLine.isHidden = true
            cell.imgRightArrow.isHidden = true
        }
        self.ArraySport = self.ArrayTrainingDataList[indexPath.row].sports!
        cell.SportCollectionview.delegate = self
        cell.SportCollectionview.dataSource = self
        cell.SportCollectionview.reloadData()
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        //header.textLabel?.font = UIFont(name: "Futura", size: 38)!
        header.textLabel?.textColor = UIColor(red: 17, green: 94, blue: 176)
        header.backgroundColor = UIColor.clear
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        header.layer.insertSublayer(gradient, at: 0)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Training", bundle: nil)
        let ivc = storyboard.instantiateViewController(withIdentifier: "TrainingDetailVC") as! TrainingDetailVC
        ivc.Course_ID = self.ArrayTrainingDataList[indexPath.row].courseId!
        ivc.Name = self.ArrayTrainingDataList[indexPath.row].courseTitle!
        navigationController?.pushViewController(ivc, animated: true)
    }
}

//MARK: Sport Category Show...
extension TrainingVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ArraySport.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCategoryCell", for: indexPath) as? SportCategoryCell else {
            return UICollectionViewCell()
        }
        cell.imgSportImage.sd_setImage(with: URL.init(string: self.ArraySport[indexPath.row].sportImage!), completed: nil)
        cell.lblSportName.text = self.ArraySport[indexPath.row].sportName
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Screenwidth = UIScreen.main.bounds.size.width
        return CGSize(width: 30, height: 30)
    }
    
}

//MARK: API Calling...
extension TrainingVC{
    func APICallMarketProductList(param: [String:String]) {
        TrainingManager.shared.GetTrainingList(param: param) { (ArrayTrainingDataList, error) in
            self.tblCources.delegate = self
            self.tblCources.dataSource = self
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
                self.tblCources.reloadData()
            }
            else if ArrayTrainingDataList.count > 0{
                self.ArrayTrainingDataList = ArrayTrainingDataList as! [TrainingHomeData]
                self.tblCources.reloadData()
            }
            else{
                Utility.setAlertWith(title: "Alert", message: "no data available", controller: self)
                self.tblCources.reloadData()
            }
        }
    }
}
