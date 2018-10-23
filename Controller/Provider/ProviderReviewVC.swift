

import UIKit
import XLPagerTabStrip

class ProviderReviewVC: UIViewController{
    
    //MARK: Outlet
    @IBOutlet weak var tblReview: UITableView!
    //==== End ====//
    
    //MERK: Variable
    var ArrayReviewList:[CourtRatingListData] = []
    var Court_ID = ""
    //==== End ===//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.estimatedRowHeight = 260.0
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserManager.shared.currentUser?.category_id == "1"{
            let param:[String:String] = ["court_id":self.Court_ID,"user_id":(UserManager.shared.currentUser?.user_id)!]
            self.APICallGetReviewList(param: param, RatingType: "court")
        }
        else if UserManager.shared.currentUser?.category_id == "2"{
            let param:[String:String] = ["course_id":self.Court_ID,"user_id":(UserManager.shared.currentUser?.user_id)!]
            self.APICallGetReviewList(param: param, RatingType: "cources")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
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
extension ProviderReviewVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.ArrayReviewList.count == 0 {
            self.tblReview.setEmptyMessage("No Review Available.")
        } else {
            self.tblReview.restore()
        }
        return self.ArrayReviewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RatingAndReviewCell", for: indexPath) as? RatingAndReviewCell  else {
            return UITableViewCell()
        }
        cell.lblName.text = self.ArrayReviewList[indexPath.row].userName
        cell.lblTimeAgo.text = self.ArrayReviewList[indexPath.row].timeAgo
        cell.imgUserImage.sd_setImage(with: URL.init(string: self.ArrayReviewList[indexPath.row].profileImage!), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
        cell.lblRatingCount.text = "\(self.ArrayReviewList[indexPath.row].rating ?? "")/\(5)"
        cell.lblRatingMSG.text = self.ArrayReviewList[indexPath.row].review
        for i in 0..<self.ArrayReviewList[indexPath.row].images!.count{
            if i == 0{
                cell.img1.sd_setImage(with: URL.init(string: self.ArrayReviewList[indexPath.row].images![i]), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
            }
            else if i == 1{
                cell.img2.sd_setImage(with: URL.init(string: self.ArrayReviewList[indexPath.row].images![i]), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
            }
            else if i == 2{
                cell.img3.sd_setImage(with: URL.init(string: self.ArrayReviewList[indexPath.row].images![i]), placeholderImage: #imageLiteral(resourceName: "square_blank_img"), completed: nil)
            }
        }
        cell.btnDelete.isHidden = false
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(ProviderReviewVC.btnDelete(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    @objc func btnDelete(sender: UIButton){
        if UserManager.shared.currentUser?.category_id == "1"{
            let alert = UIAlertController(title: "Alert", message: "Are you sure Delete Review ?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: {(action:UIAlertAction!) in
                let param:[String:String] = ["user_id":(UserManager.shared.currentUser?.user_id)!,"court_id":self.ArrayReviewList[sender.tag].courtId!,"court_rating_id":self.ArrayReviewList[sender.tag].courtRatingId!]
                ProviderManager.shared.DeleteReview(withID: param, ReviewType: "court", completion: { (isDelete, error) in
                    if isDelete == true{
                        let alert = UIAlertController(title: "Success", message: "Court Review Delete Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                            self.ArrayReviewList.remove(at: sender.tag)
                            self.tblReview.reloadData()
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        Utility.setAlertWith(title: "Error", message: error, controller: self)
                    }
                })
            }))
            alert.addAction((UIAlertAction(title: "Cancel", style: .default, handler: { (alertAction) in
            })))
            self.present(alert, animated: true, completion: nil)
        }
        else if UserManager.shared.currentUser?.category_id == "2"{
            let alert = UIAlertController(title: "Alert", message: "Are you sure Delete Review ?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Delete", style: UIAlertActionStyle.destructive, handler: {(action:UIAlertAction!) in
                let param:[String:String] = ["user_id":(UserManager.shared.currentUser?.user_id)!,"course_id":self.ArrayReviewList[sender.tag].courseId!,"course_rating_id":self.ArrayReviewList[sender.tag].courseRatingId!]
                ProviderManager.shared.DeleteReview(withID: param, ReviewType: "cources", completion: { (isDelete, error) in
                    if isDelete == true{
                        let alert = UIAlertController(title: "Success", message: "Course Review Delete Successfully.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                            self.ArrayReviewList.remove(at: sender.tag)
                            self.tblReview.reloadData()
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        Utility.setAlertWith(title: "Error", message: error, controller: self)
                    }
                })
            }))
            alert.addAction((UIAlertAction(title: "Cancel", style: .default, handler: { (alertAction) in
            })))
            self.present(alert, animated: true, completion: nil)
        }
        else if UserManager.shared.currentUser?.category_id == "3"{
           
        }
        else{
            
        }
    }
}
extension ProviderReviewVC{
    func APICallGetReviewList(param:[String:String],RatingType: String) {
        CourtAndClubManager.shared.GetCourtRatingList(Param: param, RatingType: RatingType) { (CourtRatingData, error) in
            self.tblReview.delegate = self
            self.tblReview.dataSource = self
            if error != ""{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
                self.tblReview.reloadData()
            }
            else if CourtRatingData.count > 0{
                self.ArrayReviewList = CourtRatingData as! [CourtRatingListData]
                self.tblReview.reloadData()
            }
            else{
                self.ArrayReviewList.removeAll()
                self.tblReview.reloadData()
            }
        }
    }
}

