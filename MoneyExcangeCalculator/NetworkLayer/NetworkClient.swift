//
//  NetworkClient.swift
//  MoneyExcangeCalculator
//
//  Created by Guru Prasad on 06/12/24.
//

import Foundation

protocol NetworkClient {
    func request<T: Decodable>(_ endpoint: Endpoint, modelObject: T.Type, isCertificatePinning: Bool) async -> Result<T, NetworkError>
}

class URLSessionNetworkClient: NSObject, NetworkClient {
    private let certificates: [Data] = {
        let url = Bundle.main.url(forResource: "restcountries.com", withExtension: "der")!
        let data = try! Data(contentsOf: url)
        return [data]
    }()
    private var session: URLSession
    private var isCertificatePinning: Bool = false
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ endpoint: any Endpoint, modelObject: T.Type, isCertificatePinning: Bool) async -> Result<T, NetworkError> {
        return await withCheckedContinuation { continuation in
            guard let urlRequest = endpoint.urlRequest else {
                continuation.resume(returning: .failure(NetworkError.invalidRequest))
                return
            }
            session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
            self.isCertificatePinning = isCertificatePinning
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return continuation.resume(returning: .failure(NetworkError.networkError(error)))
                }
                guard let data = data else {
                    return continuation.resume(returning: .failure(NetworkError.noData))
                }
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    return continuation.resume(returning: .success(decodedObject))
                } catch {
                    return continuation.resume(returning: .failure(NetworkError.decodingError(error)))
                }
            }
            task.resume()
        }
    }
}

extension URLSessionNetworkClient: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let trust = challenge.protectionSpace.serverTrust,
           SecTrustGetCertificateCount(trust) > 0 {
            if let certificate = SecTrustGetCertificateAtIndex(trust, 0) {
                let data = SecCertificateCopyData(certificate) as Data
                if certificates.contains(data) {
                    completionHandler(.useCredential, URLCredential(trust: trust))
                    return
                } else {
                    //TODO: Throw SSL Certificate Mismatch
                    print("Certificate mismatched")
                }
            }
        }
        completionHandler(.cancelAuthenticationChallenge, nil)
    }
}

