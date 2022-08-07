//
//  VPNTextFieldPresentable.swift
//  CommonUI
//
//  Created by Alfauser on 06.08.2022.
//

import UIKit

public protocol VPNTextFieldPresentable: CommonUIPresentable {
    var berderColor: UIColor { get set }
    var borderWidth: CGFloat { get set }
    var backgroundColor: UIColor { get set }
    var textColor: UIColor { get set }
    var textFont: UIFont { get set }
    var textInsets: UIEdgeInsets { get set }
}
