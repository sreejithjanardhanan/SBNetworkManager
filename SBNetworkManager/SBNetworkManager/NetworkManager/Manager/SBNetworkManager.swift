/*
 * SBNetworkManager.swift
 * SBNetworkManager
 *
 * Created by Sreejith Bhatt on 07/12/18.
 * Copyright © 2019 SB Studios. All rights reserved.
 * http://www.sreejithbhatt.com/
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

import Foundation

public typealias NetworkManagerCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

class SBNetworkManager: NSObject {
    
    //MARK: - Variables
    
    private var task: URLSessionTask?
    
    //MARK: - Methods
    
    func request(request:URLRequest, completion: @escaping NetworkManagerCompletion) {
        let session = URLSession.shared
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        self.task?.resume()
    }
    
    func uploadRequest(request:URLRequest, data:Data, completion: @escaping NetworkManagerCompletion) {
        let session = URLSession.shared
        task = session.uploadTask(with: request, from: data, completionHandler: { data, response, error in
            completion(data, response, error)
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func requestForURL(_ url:String, method:SBHTTPMethod, params:String?, body:[String: Any]?, headers:[String: Any]?) -> URLRequest {
        
        var request:URLRequest!
        
        if let url = URL(string:url) {
            request = URLRequest(url: url)
            // Set headers
            for (key, value) in headers! {
                request.setValue(value as? String, forHTTPHeaderField: key)
            }
            
            request.httpMethod = method.rawValue
            request.timeoutInterval = 600
            
            if body != nil {
                do {
                    let httpBody = try JSONSerialization.data(withJSONObject: body!, options:[])
                    request.httpBody = httpBody
                } catch {
                    print(error)
                }
                
            } else {
                if params != nil {
                    request.httpBody = Data(params!.utf8)
                }
            }
        }
        return request
    }
}
