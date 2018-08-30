//
//  Nibable.swift
//  TapticSampler
//
//  Created by Keisuke Tatsumi on 2018/08/22.
//  Copyright © 2018年 Keisuke Tatsumi. All rights reserved.
//

import UIKit

protocol Nibable: NSObjectProtocol {
    static var nib: UINib { get }
    static var nibName: String { get }
}

extension Nibable {
    static var nibName: String {
        return className
    }

    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }
}
