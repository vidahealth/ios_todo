//  Created by Axel Ancona Esselmann on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import UIKit

public class TodoTextField: UITextField {
    public init(text: String? = nil, placeholderText: String? = nil) {
        super.init(frame: CGRect.zero)
        
        self.text = text
        placeholder = placeholderText
        font = UIFont.systemFont(ofSize: 15)
        borderStyle = UITextField.BorderStyle.roundedRect
        autocorrectionType = UITextAutocorrectionType.no
        keyboardType = UIKeyboardType.default
        returnKeyType = UIReturnKeyType.done
        clearButtonMode = UITextField.ViewMode.whileEditing;
        contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
