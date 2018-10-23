

import UIKit

class ProceedToPayVC: UIViewController {

    //MARK: Outlet
     @IBOutlet weak var lblName: UILabel!
     @IBOutlet weak var lblDate: UILabel!
     @IBOutlet weak var lblTime: UILabel!
     @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var txtClubPolicy: UITextView!
    //=== End ===//
    
    
    //MARK: Variable
    var CourtDetailData:CourtDetailData?
    var book_avail_timeIds:[String] = []
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = CourtDetailData?.courtTitle
        lblPrice.text = "AED \(CourtDetailData?.price ?? "")"
        lblDate.text = "\(GetFormatedDate(From: "yyyy-MM-dd HH:mm:ss", To: "EEE,dd MMM", Value: (CourtDetailData?.createdAt)!) ?? "")"
        lblTime.text = "\(GetFormatedDate(From: "yyyy-MM-dd HH:mm:ss", To: "hh:mm a", Value: (CourtDetailData?.createdAt)!) ?? "")"
        txtClubPolicy.text = CourtDetailData?.descriptionField
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
        vc.book_avail_timeIds = self.book_avail_timeIds
        vc.CourtDetailData = self.CourtDetailData
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
