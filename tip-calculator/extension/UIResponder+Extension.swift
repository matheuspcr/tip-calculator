//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by MATHEUS PAES CRESCENCIO on 21/08/24.
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
