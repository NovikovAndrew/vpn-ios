//
//  CommonUIFactory.swift
//  CommonUI
//
//  Created by Alfauser on 06.08.2022.
//

import UIKit

public class CommonUIDefaultFactory: CommonUIFactoryPresentable {
    public func buildUIElement<T: UIView>(uiElement: CommonUIElement) -> T {
        switch uiElement {
        case .VPNTextField(let presentableItem):
            return VPNTextField(presentableItem: presentableItem) as! T
        }
    }
}
