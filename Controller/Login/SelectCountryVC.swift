

import UIKit
import CountryPickerView

class SelectCountryVC: UIViewController {

    //MARK: Outlet
    @IBOutlet weak var imgCountryImage: UIImageView!
    @IBOutlet weak var btnCountryName: UIButton!
    @IBOutlet weak var btnSelectCountry: UIButton!
    @IBOutlet weak var txtMobileNumber: UITextField!
    @IBOutlet weak var btnGetCode: UIButton!
    @IBOutlet weak var btnContactSupport: UIButton!
    @IBOutlet weak var btnT_C: UIButton!
    @IBOutlet weak var btnCountryWidth: NSLayoutConstraint!
    //=== End === //
    
    //MARK: Variable
    let countryPickerView = CountryPickerView()
    var userData: NSDictionary?
    //=== End ==//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryPickerView.delegate = self
        let t = countryPickerView.getCountryByCode(Locale.current.regionCode ?? "US")
        btnSelectCountry.setTitle("\(t?.phoneCode ?? "+1")", for: .normal)
        imgCountryImage.image = t?.flag
        btnCountryName.setTitle(t?.name, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action Method
    @IBAction func btnCountryName(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    @IBAction func btnSelectCountry(_ sender: Any) {
        countryPickerView.showCountriesList(from: self)
    }
    @IBAction func btnGetCode(_ sender: Any) {
        let storybord = UIStoryboard(name: "Login", bundle: nil)
        let VC = storybord.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
        navigationController?.pushViewController(VC, animated: true)
    }
    @IBAction func btnContactSupport(_ sender: Any) {
        
    }
    @IBAction func btnT_C(_ sender: Any) {
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //=== End == //

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SelectCountryVC:CountryPickerViewDelegate{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.imgCountryImage.image = country.flag
        btnCountryName.setTitle("\(country.name) >", for: .normal)
        btnSelectCountry.setTitle(country.phoneCode, for: .normal)
        let textWidth = (btnSelectCountry.currentTitle! as NSString).size(withAttributes:[NSAttributedStringKey.font:btnSelectCountry.titleLabel!.font!]).width
        btnCountryWidth.constant = textWidth + 20
        btnSelectCountry.layoutIfNeeded()
    }
}
