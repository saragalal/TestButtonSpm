import Foundation
import Alamofire

/// The Network Manager That all Services use to communicate with the API

// public typealias CallBackResponse = (APIResponse) -> Void


//// delegate for refreshToken
//public protocol NetworkManagerDelegate: AnyObject {
//    func signOut()
//    func saveToken(token: String)
//    func saveRefreshToken(token: String)
//}

public protocol HeaderDelegate: AnyObject {
   func getDefaultHttpHeaders() -> HTTPHeaders?
}
public class NetworkManager {
    // MARK: - public variables
  //  private var networkModel: NetworkModel
//    var token: String?
//    var language: String
//    
//    var deviceID: String
//    var appVersion: String
    
//    private var defaultHeaders: HTTPHeaders
    weak var headerDelgate: HeaderDelegate?
    
    public init() {
//           self.networkModel = networkModel
//           self.baseURL = networkModel.baseUrl
//           self.interceptor.setNetworkModel(networkModel)
//           self.setUpInterceptorDelegate()
       }
    
    // MARK: - private variables
     static let sharedNetworkManager = NetworkManager()
        
  private let interceptor = NetworkManagerIntercepter()
    
    /// the base url that contains the API endpoint or IP
//    private let baseURL: String
    
//    private init() {
//        if isDebug() {
//            self.baseURL = ConfigManager.urlForAlpha
//        } else {
//            self.baseURL = ConfigManager.urlForProduction
//        }
//    }
 //TODO: - check this release mode wiht samar
//    class func changeAPIMode() {
//        UserDefaults.standard.set(!self.isReleaseAPIMode(), forKey: "isReleaseMode")
//        UserDefaults.standard.synchronize()
//    }
//    
//    class func isReleaseAPIMode() -> Bool {
//        return UserDefaults.standard.bool(forKey: "isReleaseMode")
//    }
//    
//    private func setUpInterceptorDelegate() {
//        self.interceptor.signOutCallBack = delegate?.signOut
//        self.interceptor.saveToken = delegate?.saveToken(token:)
//        self.interceptor.saveRefreshToken = delegate?.saveRefreshToken(token:)
//    }
//    func getBaseUrl() -> String {
//        return self.baseURL
//    }
    
    public static func shared() -> NetworkManager {
        sharedNetworkManager
    }
    
    public func makeSimpleGetRequest(url: URL, completion: @escaping (Data?) -> Void) {
        AF.request(url).validate().response { response in
            completion(response.data)
        }
    }
    
    public func makeRequest<T: Decodable>(_ request: BaseNetworkRequest, handler: @escaping (CoreNetworkModel<T>) -> Void) {
        executeCoreModelDecodedRequest(request, useInterceptor: true, completion: handler)
    }

    public func makeRequest<T: Decodable>(_ request: BaseNetworkRequest, handler: @escaping (T?, String?) -> Void) {
        executeDecodableRequest(request, useInterceptor: true, completion: handler)
    }

//    func makeRequest<T: Decodable>(_ request: BaseNetworkRequest, body: Encodable, handler: @escaping (CoreNetworkModel<T>) -> Void) {
//        guard let url = URL(string: request.getURL()) else {
////            dLog("⛔️⛔️ Cannot Generate URL \(baseURL+request.getURL()) ⛔️⛔️")
//            return
//        }
//        
//        AF.request(url,
//                   method: request.getHTTPMethod(),
//                   parameters: body,
//                   encoder: URLEncodedFormParameterEncoder.default,
//                   headers: .init(request.getHeaders().map { HTTPHeader(name: $0.key, value: $0.value) }),
//                   interceptor: interceptor)
//        .validate()
//        .responseDecodable { result in
//            handler(result.value ?? CoreNetworkModel(errors: [NetworkError(message: result.error?.localizedDescription)]))
////            dLog("⚠️⚠️ \n \(self.baseURL+request.getURL()) \n \(String(describing: result.value)) \n \(String(describing: result.error?.errorDescription)) \n  ⚠️⚠️")
//        }
//    }
    
    // swiftlint:disable force_unwrapping
//    func makeRequestMultipart<T: BaseMappable>(_ request: BaseNetworkRequest, handler: @escaping (DataResponse<T, AFError>) -> Void) {
//        
//        var param = request.getParameters()
//        if param?.isEmpty ?? true {
//            param = nil
//        }
//        
//        AF.upload(multipartFormData: { (multipartFormData) in
//            for (key, value) in param ?? [:] {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//            let imagesDataArr = request.getImages()?.compactMap { $0.wxCompress().jpegData(compressionQuality: 0.1) } ?? []
//            for imageData in imagesDataArr {
//                multipartFormData.append(imageData, withName: "images" as String, fileName: "picture.png", mimeType: "image/jpeg")
//            }
//        }, to: baseURL+request.getURL(), usingThreshold: UInt64.init(), method: .post,
//                  headers: .init(request.getHeaders().map { HTTPHeader(name: $0.key, value: $0.value) }),
//                  interceptor: interceptor,
//                  fileManager: FileManager())
//        .responseObject(completionHandler: handler)
//    }
    
//    func executeMappableRequest<T: Mappable>(_ request: BaseNetworkRequest, useInterceptor: Bool, completion: @escaping (BaseNetworkModel<T>) -> Void) {
//        guard let dataRequest = makeAFRequest(from: request, useInterceptor: useInterceptor, useCustomValidation: true) else {
////            dLog("⛔️⛔️ Cannot Generate URL \(baseURL+request.getURL()) ⛔️⛔️")
//            completion(BaseNetworkModel(errors: NetworkError.getDetault()))
//            return
//        }
//        
//        dataRequest
//            .responseObject { (response: DataResponse<BaseNetworkModel<T>, AFError>) in
//            if let value = response.value {
//                completion(value)
//            } else {
//                completion(BaseNetworkModel(errors: NetworkError.getDetault()))
//            }
////            dLog("⚠️⚠️ \n \(self.baseURL+request.getURL()) \n \(response) \n \(String(describing: response.data)) \n  ⚠️⚠️")
//        }
//    }
    
   private func executeCoreModelDecodedRequest<T: Decodable>(_ request: BaseNetworkRequest, useInterceptor: Bool, completion: @escaping (CoreNetworkModel<T>) -> Void) {
        executeDecodableRequest(request, useInterceptor: useInterceptor) { (result: CoreNetworkModel<T>?, _) in
            completion(result ?? CoreNetworkModel(errors: NetworkError.getDetault()))
        }
    }

   private func executeDecodableRequest<T: Decodable>(_ request: BaseNetworkRequest, useInterceptor: Bool, completion: @escaping (T?, String?) -> Void) {
       var headers = self.headerDelgate?.getDefaultHttpHeaders() ?? [:]
               request.getHeaders().forEach { header in
                   headers.add(HTTPHeader(name: header.key, value: header.value))
               }
        guard let dataRequest = makeAFRequest(from: request, useInterceptor: useInterceptor, useCustomValidation: false) else {
//            dLog("⛔️⛔️ Cannot Generate URL \(baseURL+request.getURL()) ⛔️⛔️")
            completion(nil, "ErrorMessages.defaultErrorMessage.localized")
            return
        }

        dataRequest
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case let .success(model):
                    completion(model, nil)
                case .failure:
                    if let json = response.data, let errorModel = try? JSONDecoder().decode(T.self, from: json) {
                        completion(errorModel, nil)
                    } else {
                        completion(nil, "ErrorMessages.defaultErrorMessage.localized")
                    }
                }
//                dLog("⚠️⚠️ \n \(self.baseURL+request.getURL()) \n \(response) \n \(String(describing: response.data)) \n  ⚠️⚠️")
            }
    }

    private func makeAFRequest(from request: BaseNetworkRequest, useInterceptor: Bool, useCustomValidation: Bool) -> DataRequest? {
        guard let url = URL(string: request.getURL()) else {
           // dLog("⛔️⛔️ Cannot Generate URL \(baseURL+request.getURL()) ⛔️⛔️")
            return nil
        }
        
        var param = request.getParameters()
        if param?.isEmpty ?? true {
            param = nil
        }
        
        let request = AF.request(url,
                                 method: request.getHTTPMethod(),
                                 parameters: param,
                                 encoding: request.getParameterEncoding(),
                                 headers: .init(request.getHeaders().map { HTTPHeader(name: $0.key, value: $0.value) }),
                                 interceptor: useInterceptor ? interceptor : nil)
            .cURLDescription { description in
               // dLog(description)
            }
        
        return request
            // .validate()
    }
}
// swiftlint:enable force_unwrapping

//// TODO: Remove this after getting rid of mappable
//extension DataRequest {
//    
//    func customValidate() -> Self {
//        validate { _, response, _ -> Request.ValidationResult in
//            if response.statusCode.isAuthenticationErrorCode {
//                return .failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 401)))
//            } else {
//                return .success(())
//            }
//        }
//    }
//}
