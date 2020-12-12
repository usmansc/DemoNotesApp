//
//  MultiLineTextField.swift
//  NotesDemo
//
//  Created by Lukas Schmelcer on 11/12/2020.
//

import Foundation
import SwiftUI

// UIKit view do SwiftUI

struct MultiLineTextField : UIViewRepresentable{
    
    @Binding var text: String
    var placeholder: String = "Poznámka"
    
    class Coordinator: NSObject, UITextViewDelegate{
        var parent: MultiLineTextField
        
        init(parent: MultiLineTextField) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == .placeholderText{
                textView.text = ""
                textView.textColor = .label
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
                textView.text = parent.placeholder
                textView.textColor = .placeholderText
            }
        }
    }
    
    func makeCoordinator() -> MultiLineTextField.Coordinator {
        Coordinator(parent: self)
    }
    
    
    func makeUIView(context: UIViewRepresentableContext<MultiLineTextField>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator
        textField.font = UIFont.systemFont(ofSize: 17)
        
        textField.text = placeholder
        textField.textColor = .placeholderText
        return textField
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiLineTextField>) {
        if (text.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 || uiView.textColor == .label){
            uiView.text = text
            uiView.textColor = .label
            
        }
        
        uiView.delegate = context.coordinator
    }
    
    typealias UIViewType = UITextView
}
