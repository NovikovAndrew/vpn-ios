//
//  CommonUIFactoryPresentable.swift
//  CommonUI
//
//  Created by Alfauser on 06.08.2022.
//

import UIKit.UIView

public protocol CommonUIFactoryPresentable {
    func buildUIElement<T: UIView>(uiElement: CommonUIElement) -> T
}
