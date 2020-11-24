//
//  BaseDao.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit

let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! + "/Music.db"
struct BaseDao {
    static let dbQueue: FMDatabaseQueue = FMDatabaseQueue(path: dbPath)!
}
