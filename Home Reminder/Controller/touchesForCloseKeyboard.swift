//
//  touchesForCloseKeyboard.swift
//  Home Mention
//
//  Created by Владислав on 12/09/2019.
//  Copyright © 2019 Vladislav Samelchuk. All rights reserved.
//

import UIKit

class CustomTableView: UITableView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        endEditing(false)
    }
}
