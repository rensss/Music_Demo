//
//  NetworkConstants.swift
//  Music
//
//  Created by Rzk on 2020/11/20.
//

import Foundation
import Moya
import Alamofire

let domain = "http://xj.greatmusictube.com/music"

private let serverTrustPolicies: [String: ServerTrustPolicy] = [
	domain: .disableEvaluation
]
let configuration: URLSessionConfiguration = {
	let config = URLSessionConfiguration.default
	config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
	config.timeoutIntervalForRequest = 40
	config.timeoutIntervalForResource = 40
	config.requestCachePolicy = .useProtocolCachePolicy
	return config
}()

private let manger = Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
let NetworkAPIRequest = MoyaProvider<RequestApi>(manager: manger)


enum RequestApi {
	case artist
	case artistdetail(singer_id: String)
}

extension RequestApi: TargetType {
	
	var headers: [String : String]? {
		return nil
	}
	
	var baseURL: URL {
		switch self {
		default:
			return URL(string: domain)!
		}
	}
	
	var path: String {
		switch self {
		case .artist:
			return "artist"
		case .artistdetail:
			return "artistdetail"
		}
	}
	
	var method: Moya.Method {
		switch self {
		default:
			return .get
		}
	}
	
	var sampleData: Data {
		return "".data(using: String.Encoding.utf8)!
	}
	
	var task: Task {
		if parameters != nil {
			return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
		} else {
			return .requestPlain
		}
	}
	
	
	var parameters: [String: Any]? {
		var dict = [String: Any]()
		switch self {
		case .artistdetail(singer_id: let singer_id):
			dict["singer_id"] = singer_id
		default:
			break
		}
		return dict
	}
	
}


//class MusicNetAPIProvider {
//	private static let shareInstance = MusicNetAPIProvider()
//
//	private init(){
//		// 设置请求的超时时间
//		let config = URLSessionConfiguration.default
//		config.timeoutIntervalForRequest = 20    // 秒
//		let netmanager = Manager(configuration: config)
//
//		let networkplugin = NetworkActivityPlugin {
//			(change,target) in
//			switch change {
//			case .began: UIApplication.shared.isNetworkActivityIndicatorVisible = true
//			case .ended: UIApplication.shared.isNetworkActivityIndicatorVisible = false
//			}
//		}
//
//		shareProvider = MoyaProvider<RequestApi>(manager: netmanager,plugins:[networkplugin])
//	}
//
//	private var shareProvider: MoyaProvider<RequestApi>
//
//	class var provider: MoyaProvider<RequestApi>{
//		return shareInstance.shareProvider
//	}
//}
