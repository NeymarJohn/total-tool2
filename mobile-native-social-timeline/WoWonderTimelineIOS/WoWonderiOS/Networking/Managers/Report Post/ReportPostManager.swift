
import Foundation
import Alamofire
import WoWonderTimelineSDK


class ReportPostManager{
    
    func reportPost(postId: String,completionBlock :@escaping (_ Success: ReportPostModal.reportPost_SuccessModal?, _ AuthError: ReportPostModal.reportPost_ErrorModal?, Error?)->()){
        let params = [APIClient.Params.serverKey:APIClient.SERVER_KEY.Server_Key,APIClient.Params.action: "report",APIClient.Params.postId:postId]
        let access_token = "\("?")\("access_token")\("=")\(UserData.getAccess_Token()!)"
        
        Alamofire.request(APIClient.ReportPost.reportPostApi + access_token, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.value != nil{
                guard let res = response.result.value as? [String:Any] else {return}
                guard let apiStatusCode = res["api_status"] as? Any else {return}
                if apiStatusCode as? Int == 200 {
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    guard let result = try? JSONDecoder().decode(ReportPostModal.reportPost_SuccessModal.self, from: data) else{return}
                    completionBlock(result,nil,nil)
                }
                else{
                    guard let data = try? JSONSerialization.data(withJSONObject: response.value, options: []) else {return}
                    guard let result = try? JSONDecoder().decode(ReportPostModal.reportPost_ErrorModal.self, from: data) else {return}
                    completionBlock(nil,result,nil)
                }
            }
            else{
                print(response.error?.localizedDescription)
                completionBlock(nil,nil,response.error)
            }
        }
    }
    
    func reportedPost(targetController: UIViewController, postId: String){
        performUIUpdatesOnMain {
            self.reportPost(postId: postId) { (success, authError, error) in
                if success != nil {
                    targetController.view.makeToast("Reported")
                }
                else if authError != nil{
                    targetController.view.makeToast(authError?.errors.errorText)
                }
                else{
                    targetController.view.makeToast(error?.localizedDescription)
                }
            }
        }
    }
    
    static let sharedInstance = ReportPostManager()
    private init () {}
    
}
