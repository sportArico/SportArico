

import UIKit
import XLPagerTabStrip

class TrainingRatingVC: UIViewController,IndicatorInfoProvider{
    
    
    var itemInfo: IndicatorInfo = IndicatorInfo(title: "Review")
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    //MARK: Outlet
    @IBOutlet weak var tblReview: UITableView!
    //==== End ====//
    
    //MERK: Variable
    var ArrayReviewList:[CourtRatingListData] = []
    var Course_ID = ""
    //==== End ===//
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.estimatedRowHeight = 260.0
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let param:[String:String] = ["course_id":self.Course_ID,"user_id":(UserManager.shared.currentUser?.user_id)!]
        self.APICallGetReviewList(param: param)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension TrainingRatingVC:UITableViewDelegate,UITableViewDataSource{
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
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
extension TrainingRatingVC{
    func APICallGetReviewList(param:[String:String]) {
        CourtAndClubManager.shared.GetCourtRatingList(Param: param, RatingType: "cources") { (CourtRatingData, error) in
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

