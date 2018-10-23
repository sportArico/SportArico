

import UIKit
import ImageSlideshow
import CreditCardValidator

class AddCardVC: UIViewController{

    
    //MARK: Outlet
    @IBOutlet weak var SlideShow: ImageSlideshow!
    @IBOutlet weak var txtCardHolder: UITextField!
    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpireDate: UITextField!
    @IBOutlet weak var txtCVV: UITextField!
    @IBOutlet weak var IsAutoDebit: UISwitch!
    //=== End ===//
    
    //MARK: Variable
    var month = ""
    var year = ""
    var datePicker = MonthYearPickerView()
    var book_avail_timeIds:[String] = []
    var CourtDetailData:CourtDetailData?
    //=== End ===//
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSlideShow()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Slideshow
    func initSlideShow()
    {
       // let localSource:[ImageSource] = [ImageSource(image:#imageLiteral(resourceName: "top_img")),ImageSource(image: #imageLiteral(resourceName: "BG.png")),ImageSource(image: #imageLiteral(resourceName: "top_bg"))]
        
        SlideShow.backgroundColor = UIColor.white
        SlideShow.slideshowInterval = 5.0
        SlideShow.pageControlPosition = PageControlPosition.insideScrollView
        //        slideshow.pageControlPosition = PageControlPosition.custom(padding: 30.0)
        SlideShow.pageControl.currentPageIndicatorTintColor = UIColor.black
        SlideShow.pageControl.pageIndicatorTintColor = UIColor.lightGray
        SlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        SlideShow.activityIndicator = DefaultActivityIndicator()
        //SlideShow.setImageInputs(localSource)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func txtExpireDate(_ sender: Any) {
        self.pickUpDate(txtExpireDate)
        self.datePicker.onDateSelected = { (month: Int, year: Int) in
            let string = String(format: "%02d/%d", month, year)
            NSLog(string) // should show something like 05/2015
            self.month = "\(month)"
            self.year = "\(year)"
            self.txtExpireDate.text = "\(string)"
        }
    }
    
    @IBAction func btnCheckOut(_ sender: Any) {
        guard (txtCardHolder.text  == "" ? nil : txtCardHolder.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Valid Card Holder Name", controller: self)
            return
        }
        guard (txtCardNumber.text  == "" ? nil : txtCardNumber.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Valid Card Number", controller: self)
            return
        }
        guard (txtExpireDate.text  == "" ? nil : txtExpireDate.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Valid Ex-Date", controller: self)
            return
        }
        guard (txtCVV.text  == "" ? nil : txtCVV.text) != nil else {
            Utility.setAlertWith(title: "Alert", message: "Please Enter Valid CVV", controller: self)
            return
        }
        let v = CreditCardValidator()
        if v.validate(string: txtCardNumber.text!){
            // Card number is valid
        } else {
            // Card number is invalid
            Utility.setAlertWith(title: "Alert", message: "Please Enter Valid Card Number", controller: self)
            return
        }
        var isAutoDebit = ""
        if self.IsAutoDebit.isOn{
            isAutoDebit = "1"
        }
        else
        {
            isAutoDebit = "0"
        }
        let param:[String:String] = ["user_id":(UserManager.shared.currentUser?.user_id)!,"card_number":txtCardNumber.text!,"card_name":txtCardHolder.text!,"expiry_month":self.month,"expiry_year":self.year,"cvv":txtCVV.text!,"auto_debit":isAutoDebit]
        
        AddCardManager.shared.AddCard(withParametrs: param) { (isAdded, error) in
            if isAdded{
                self.txtCardNumber.text = ""
                self.txtCardHolder.text = ""
                self.txtExpireDate.text = ""
                self.txtCVV.text = ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    let param:[String:String] = ["court_id":(self.CourtDetailData?.courtId)!,"user_id":(UserManager.shared.currentUser?.user_id)!,"amount":(self.CourtDetailData?.price)!,"transaction_id":"12345","order_status":"completed","book_avail_ids":self.book_avail_timeIds.joined(separator: ",")]
                    CourtAndClubManager.shared.BookCourt(param: param, completion: { (isBook, error) in
                        if isBook == true{
                            let alert = UIAlertController(title: "Success", message: error, preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                let ivc = storyboard.instantiateViewController(withIdentifier: "AddRatingAndReviewVC") as! AddRatingAndReviewVC
                                ivc.modalPresentationStyle = .overCurrentContext
                                ivc.modalTransitionStyle = .coverVertical
                                ivc.Court_ID = (self.CourtDetailData?.courtId)!
                                ivc.ReviewType = "court"
                                ivc.OnBack = { (isBack) in
                                    if isBack == true{
                                        self.navigationController?.popToRootViewController(animated: true)
                                    }
                                }
                                self.present(ivc, animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                        else{
                            Utility.setAlertWith(title: "Error", message: error, controller: self)
                        }
                    })
                })
            }else{
                Utility.setAlertWith(title: "Error", message: error, controller: self)
            }
        }
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
//MARK: DatePicker method
extension AddCardVC{
    func pickUpDate(_ textField : UITextField){
        // DatePicker
       self.datePicker = MonthYearPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        //self.datePicker.backgroundColor = UIColor.white
        //self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(AddNewMarketVC.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddNewMarketVC.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    @objc func doneClick() {
        self.txtExpireDate.resignFirstResponder()
        
    }
    @objc func cancelClick() {
        self.txtExpireDate.resignFirstResponder()
    }
    
}
