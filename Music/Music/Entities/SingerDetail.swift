//
//  SingerDetail.swift
//  Music
//
//  Created by RZK on 2020/11/22.
//

import Foundation

struct SingerDetail: Codable {
	var playlist_id: Int
	var playlist_name: String
	var playlist_img_url: String
	var mv_total_count: Int
	var mv_items: [Mv]
}
