

import UIKit

class OffersBarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.barTintColor = UIColor.colorFromHex(hexString: "#F274B4")
        // Do any additional setup after loading the view.
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
    //MARK : TabBar Delegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 3:
            let Categorystorybord = UIStoryboard(name: "Category", bundle: nil)
            let VC = Categorystorybord.instantiateViewController(withIdentifier: "navcategory")
            show(VC, sender: self)
            break
        default:
            break
        }
    }

}
