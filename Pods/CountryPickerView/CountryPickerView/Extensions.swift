//
//  Extensions.swift
//  CountryPickerView
//
//  Created by Kizito Nwose on 18/09/2017.
//  Copyright © 2017 Kizito Nwose. All rights reserved.
//

import UIKit

extension UIWindow {
    var topViewController: UIViewController? {
        guard var top = rootViewController else {
            return nil
        }
        while let next = top.presentedViewController {
            top = next
        }
        return top
    }
}

extension UINavigationController {
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
//MARK: -device type
extension UIViewController {
    
    public enum SizeType: CGFloat {
        case Unknown = 0.0
        case iPhone4 = 960.0
        case iPhone5_Se = 1136.0
        case iPhone6_6s_7_8 = 1334.0
        case iPhone6_6s_7_8_Plus = 2208.0
        case iPhoneX = 2436.0
    }
    
    public var deviceType: SizeType {
        let height = UIScreen.main.nativeBounds.height
        guard let sizeType = SizeType(rawValue: height) else { return .Unknown }
        return sizeType
    }
    
    /*
     if UIScreen.main.sizeType == .iPhoneX
     {}
     */
}






