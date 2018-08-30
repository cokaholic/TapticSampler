//
//  UITableViewExtension.swift
//  TapticSampler
//
//  Created by Keisuke Tatsumi on 2018/08/22.
//  Copyright © 2018年 Keisuke Tatsumi. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: Nibable>(_ cell: T.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.className)
    }

    func dequeueReusableCell<T: Nibable>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}
