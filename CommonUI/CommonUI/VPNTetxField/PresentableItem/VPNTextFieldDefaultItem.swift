//
//  VPNTextFieldDefaultItem.swift
//  CommonUI
//
//  Created by Alfauser on 06.08.2022.
//

import UIKit
import Utilities

public enum VPNTextFieldPresntable: VPNTextFieldPresentable {
    case defaultVpn
    
    
    public var berderColor: UIColor {
        switch self {
        case .defaultVpn:
            return .black
        }
    }
    
    public var borderWidth: CGFloat {
        switch self {
        case .defaultVpn:
            return 2
        }
    }
    
    public var backgroundColor: UIColor {
        switch self {
        case .defaultVpn:
            return .red
        }
    }
    
    public var textColor: UIColor {
        switch self {
        case .defaultVpn:
            return .black
        }
    }
    
    public var textFont: UIFont {
        switch self {
        case .defaultVpn:
            return .systemFont(ofSize: 14)
        }
    }
    
    public var textInsets: UIEdgeInsets {
        switch self {
        case .defaultVpn:
            return .zero
        }
    }
}
