# SBNetworkManager

This is a network library to fetch web-service API response for iOS written in Swift 4.0.

# Requirements

* iOS 8.0+
* XCode 9.0+
* Swift 4.2

# Installation

#### Manual

The files needed to be included are in the **NetworkManager** subfolder of this project.

# Setup

1. Declare network manager variable :

        let networkManager = SBNetworkManager()

2. Set method type, params, body, header in request object :


        // Set method type, params, body, header here -->
        
        let header  = ["Content-Type": "application/json"] as [String : Any]
        
        // Create request object
        
        let request = networkManager.requestForURL(kURL, method:SBHTTPMethod.post, params:nil, body:nil, headers: header)
        
        // 
3. Pass request to network manager and invoke network manager API :
        
        networkManager.request(request: request) { (data, response, error) in
            
            // Receive response here --->
        }


