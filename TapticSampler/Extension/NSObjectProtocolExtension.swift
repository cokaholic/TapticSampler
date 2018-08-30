//
//  NSObjectProtocolExtension.swift
//  TapticSampler
//
//  Created by Keisuke Tatsumi on 2018/08/22.
//  Copyright © 2018年 Keisuke Tatsumi. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}
