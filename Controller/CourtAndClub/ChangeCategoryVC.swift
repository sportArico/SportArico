

import UIKit

class ChangeCategoryVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnCourts: UIButton!
    @IBOutlet weak var btnSocial: UIButton!
    @IBOutlet weak var btnMarket: UIButton!
    @IBOutlet weak var btnTrainings: UIButton!
    @IBOutlet weak var btnOffers: UIButton!
    //=== End ===//
    
    var selectedCategory = UserDefaults.standard.value(forKey: "Category") as! String
    let width = 80
    let height = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        btnCancel.layer.cornerRadius = btnCancel.frame.size.height / 2
        btnCancel.clipsToBounds = true
        
        if selectedCategory == "CourtAndClub"{
            btnCourts.translatesAutoresizingMaskIntoConstraints = false
            btnCourts.frame.size = CGSize(width: self.width, height: self.height)
        }
        else if selectedCategory == "Social"{
            btnCourts.translatesAutoresizingMaskIntoConstraints = false
            btnCourts.frame.size = CGSize(width: self.width, height: self.height)
        }
        else if selectedCategory == "Market"{
            btnCourts.frame.size = CGSize(width: self.width, height: self.height)
        }
        else if selectedCategory == "Courses"{
            btnCourts.frame.size = CGSize(width: self.width, height: self.height)
        }
        else if selectedCategory == "Offers"{
            btnCourts.frame.size = CGSize(width: self.width, height: self.height)
        }
        else{
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCourt(_ sender: Any) {
        ChangeCategoryClass.shared.OpenCourtVC()
    }
    @IBAction func btnSocial(_ sender: Any) {
        ChangeCategoryClass.shared.OpenSocialVC()
    }
    @IBAction func btnMarket(_ sender: Any) {
        ChangeCategoryClass.shared.OpenMarketVC()
    }
    @IBAction func btnTraining(_ sender: Any) {
        ChangeCategoryClass.shared.OpenTrainingVC()
    }
    @IBAction func btnOffers(_ sender: Any) {
        ChangeCategoryClass.shared.OpenOffersVC()
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
