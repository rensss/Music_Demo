//
//  BaseDao.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit

let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/Music.db"
class BaseDao {
    let database: FMDatabase = FMDatabase(path: path)
}
