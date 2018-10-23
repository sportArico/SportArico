

import Foundation
import Foundation
import UIKit

class Utility: NSObject {
    
    class func setAlertWith(title:String?, message:String?, controller: UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            // Nothing
        }))
        
        controller.present(alertController, animated: true, completion: nil)        
        
    }
    
}
