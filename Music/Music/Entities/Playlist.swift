//
//  Playlist.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation

struct Playlist: Codable {
	var playlist_id: String
	var playlist_name: String
	var playlist_img_url: String
	var mv_total_count: Int
	var mv_items: [Mv]
}
