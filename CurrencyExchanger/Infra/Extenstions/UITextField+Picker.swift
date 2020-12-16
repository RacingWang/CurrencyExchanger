//
//  UITextField+Picker.swift
//  CurrencyExchanger
//
//  Created by Racing on 2020/12/16.
//

import Foundation
import UIKit

extension UITextField {
    typealias PickerViewCompletion = (Int) -> Void
    typealias DatePickerCompletion = (Date) -> Void

    struct AssociatedKeys {
        static var pickerViewCompletion = "pickerViewCompletion"
        static var datePickerCompletion = "datePickerCompletion"
    }
    
    private var pickerViewCompletion: PickerViewCompletion? {
        get {
           let completion = objc_getAssociatedObject(self, &AssociatedKeys.pickerViewCompletion) as? PickerViewCompletion
            return completion
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.pickerViewCompletion, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func bind(pickerView: UIPickerView, completion: @escaping PickerViewCompletion) {
        pickerViewCompletion = completion
        inputView = pickerView
        setupToolBar()
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "done".localized,
                                         style: .plain,
                                         target: self,
                                         action: #selector(onPressPickerDoneButton(_:)))
        let cancelButton = UIBarButtonItem(title: "cancel".localized,
                                           style: .plain,
                                           target: self,
                                           action: #selector(onPressPickerCancelButton(_:)))

        toolBar.setItems([cancelButton, flexible, doneButton], animated: false)
        inputAccessoryView = toolBar
    }
    
    @objc func onPressPickerDoneButton(_ sender: Any) {
        if let picker = inputView as? UIPickerView {
            let index = picker.selectedRow(inComponent: 0)            
            pickerViewCompletion?(index)
            
        }

        resignFirstResponder()
    }
    
    @objc
    func onPressPickerCancelButton(_ sender: Any) {
        resignFirstResponder()
    }
}
