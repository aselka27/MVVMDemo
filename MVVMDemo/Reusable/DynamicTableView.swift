//
//  DynamicTableView.swift
//  MVVMDemo
//
//  Created by саргашкаева on 22.03.2023.
//

import UIKit


class DynamicTableView: UITableView {
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
}
