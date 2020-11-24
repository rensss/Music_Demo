//
//  PlaylistDao.swift
//  Music
//
//  Created by Rzk on 2020/11/23.
//

import UIKit

struct PlaylistDao {
    static func creatTable() {
        BaseDao.dbQueue.inDatabase { (db) in
            do {
                try db.executeUpdate("CREATE TABLE IF NOT EXISTS PlaylistTable (id integer primary key autoincrement, singer_id, playlist_id text, playlist_name text, playlist_img_url text, mv_total_count integer, mv_items text)", values: nil)
                debugPrint("CREATE PlaylistTable SUCCESS")
            } catch {
                debugPrint("failed: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK:- 增
    static func addPlaylist(singer: Singer?) -> Bool {
        
        // , let list = playlist.first
        guard let playlist = singer?.playlists else {
            return true
        }
        
        var result = false

        for list in playlist {
            BaseDao.dbQueue.inDatabase { (db) in
                guard let mvData = try? JSONEncoder().encode(list.mv_items) else { return }
                debugPrint(String(data: mvData, encoding: .utf8)!)
                
                do {
                    try db.executeUpdate("INSERT INTO PlaylistTable (singer_id, playlist_id, playlist_name, playlist_img_url, mv_total_count, mv_items) VALUES (?, ?, ?, ?, ?)", values: [list.playlist_id, list.playlist_name, list.playlist_img_url, list.mv_total_count, mvData])
                    result = true
                } catch {
                    debugPrint("executeUpdate failed: \(error.localizedDescription)")
                }
            }
        }
        
        
        return result
    }
    
    // MARK:- 删
    
    
    // MARK:- 改
    
    
    // MARK:- 查
    static func getAllPlaylist() -> [Playlist] {
        var array: [Playlist] = []
        BaseDao.dbQueue.inDatabase({ (db) in
            do {
                let rs = try db.executeQuery("SELECT * FROM PlaylistTable", values: nil)
                while rs.next() {
                    let id = rs.string(forColumn: "playlist_id")
                    let name = rs.string(forColumn: "playlist_name")
                    let url = rs.string(forColumn: "playlist_img_url")
                    let count = rs.int(forColumn: "mv_total_count")
                    let mvJson = rs.string(forColumn: "mv_items")
                    
                    let decoder = JSONDecoder()
                    let mvs = try decoder.decode([Mv].self, from: (mvJson?.data(using: .utf8))!) as [Mv]
                    let list = Playlist(playlist_id: id ?? "", playlist_name: name ?? "", playlist_img_url: url ?? "", mv_total_count: Int(count), mv_items: mvs)
                    array.append(list)
                }
            } catch {
                debugPrint("SELECT failed: \(error.localizedDescription)")
            }
        })
        
        return array
    }
    
    static func getPlaylist(playlist_id: String) -> Playlist? {
        var play: Playlist?
        BaseDao.dbQueue.inDatabase({ (db) in
            do {
                let rs = try db.executeQuery("SELECT * FROM PlaylistTable WHERE playlist_id = ?", values: [playlist_id])
                while rs.next() {
                    let id = rs.string(forColumn: "playlist_id")
                    let name = rs.string(forColumn: "playlist_name")
                    let url = rs.string(forColumn: "playlist_img_url")
                    let count = rs.int(forColumn: "mv_total_count")
                    let mvJson = rs.string(forColumn: "mv_items")
                    
                    let decoder = JSONDecoder()
                    let mvs = try decoder.decode([Mv].self, from: (mvJson?.data(using: .utf8))!) as [Mv]
                    
                    play = Playlist(playlist_id: id ?? "", playlist_name: name ?? "", playlist_img_url: url ?? "", mv_total_count: Int(count), mv_items: mvs)
                }
            } catch {
                debugPrint("SELECT failed: \(error.localizedDescription)")
            }
        })
        
        return play ?? nil
    }
    
}
