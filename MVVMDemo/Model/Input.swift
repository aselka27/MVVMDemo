//
//  Input.swift
//  MVVMDemo
//
//  Created by саргашкаева on 22.03.2023.
//

import Foundation


enum InputType {
    case Password
    case DatePicker
    case OtherField
}


struct UserInput {
    let input: String
    let placeholder: String
    let type: InputType
}
