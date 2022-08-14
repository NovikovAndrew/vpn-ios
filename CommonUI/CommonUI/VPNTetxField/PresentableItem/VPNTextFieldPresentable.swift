//
//  VPNTextFieldPresentable.swift
//  CommonUI
//
//  Created by Alfauser on 06.08.2022.
//

import UIKit

public protocol VPNTextFieldPresentable: CommonUIPresentable {
    var berderColor: UIColor { get }
    var borderWidth: CGFloat { get }
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var textFont: UIFont { get }
    var textInsets: UIEdgeInsets { get }
}
