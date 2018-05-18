//
//  NetworkTools.swift
//
//  Created by lawalong on 16/7/4.
//

import UIKit
import AFNetworking
import SVProgressHUD
import Alamofire

class NetworkTools: AFHTTPSessionManager {
    
    static let shareInstance: NetworkTools = {
        let baseURL = URL(string:"Basic Server URL")!
        let instance = NetworkTools(baseURL: baseURL,
                                    sessionConfiguration: URLSessionConfiguration.default)
        return instance
    }()
    
    
    /// get db update data
    func getUpdataData(_ version:Int,finished: @escaping (_ update_result_array:[UpDateItem]?,_ Sversion:Int,_ error:NSError?)->()){
        let URL = "your API URL"
                Alamofire.request(.POST, URL, parameters: ["current_version": String(version)]).responseObject{(response: Response<dbUpdateResponse, NSError>) in
                    let updateResponse = response.result.value
                    let updateDeatil = updateResponse?.UpDateData
                    var Sversion = updateResponse?.Sversion
                    if Sversion == nil{
                        Sversion = 1
                    }
                    finished(update_result_array: updateDeatil, Sversion: Sversion!, error: nil)
        }
    }
    
    
}

