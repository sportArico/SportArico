

import UIKit

class ProceedToPayCourcesVC: UIViewController {
    
    //MARK: Outlet
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtClubPolicy: UITextView!
    //=== End ===//
    
    
    //MARK: Variable
    var TrainingSportDetailData:TrainingDetailData?
    var book_avail_timeIds:[String] = []
    var Total = Float()
    var isIncludPlace = ""
    var isIncludSport_tool = ""
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = TrainingSportDetailData?.courseTitle
        lblPrice.text = "AED \(Total)"
        lblDate.text = "\(GetFormatedDate(From: "yyyy-MM-dd HH:mm:ss", To: "EEE,dd MMM", Value: (TrainingSportDetailData?.createdAt)!) ?? "")"
        lblTime.text = "\(GetFormatedDate(From: "yyyy-MM-dd HH:mm:ss", To: "hh:mm a", Value: (TrainingSportDetailData?.createdAt)!) ?? "")"
        txtClubPolicy.text = TrainingSportDetailData?.termsAndCondition
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func btnProceedToPay(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Training", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddCardCourcesVC") as! AddCardCourcesVC
        vc.book_avail_timeIds = self.book_avail_timeIds
        vc.TrainingSportDetailData = self.TrainingSportDetailData
        vc.Total = self.Total
        vc.isIncludSport_tool = self.isIncludSport_tool
        vc.isIncludPlace = self.isIncludPlace
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

