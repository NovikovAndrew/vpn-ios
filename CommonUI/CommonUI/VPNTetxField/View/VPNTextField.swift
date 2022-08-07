//
//  VPNTextField.swift
//  CommonUI
//
//  Created by Alfauser on 06.08.2022.
//

import UIKit

public class VPNTextField: UITextField {
    
    // MARK: - Private
    
    private var presentableItem: VPNTextFieldPresentable
    
    
    // MARK: - Object livecycle
    
    public required init(frame: CGRect = .zero, presentableItem: VPNTextFieldPresentable) {
        self.presentableItem = presentableItem
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
