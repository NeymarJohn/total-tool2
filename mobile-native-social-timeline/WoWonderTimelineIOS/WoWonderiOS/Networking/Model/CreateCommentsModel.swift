
import Foundation

class CreateCommentModel {
    
 
    struct createComment_SuccessModel{
        
        var api_status : Int
        var data : [String:Any]
    }
    
    
    struct  createComment_ErrorModel : Codable {
        
        let apiStatus: String
        let errors: Errors
        
        enum CodingKeys: String, CodingKey {
            case apiStatus = "api_status"
            case errors
        }
    }
    
    struct Errors: Codable {
        let errorID, errorText: String
        
        enum CodingKeys: String, CodingKey {
            case errorID = "error_id"
            case errorText = "error_text"
        }
    }
}

extension CreateCommentModel.createComment_SuccessModel{
    
    init(json : [String:Any]){
    
    let api_status = json["api_status"] as? Int
    let data = json["data"] as? [String:Any]
    self.api_status = api_status ?? 0
    self.data = data ?? ["PostType" : "Profile_Pic"]
    
 }

}
