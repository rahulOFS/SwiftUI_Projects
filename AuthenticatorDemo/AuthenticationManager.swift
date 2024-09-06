import Foundation
import LocalAuthentication

class AuthenticationManager : ObservableObject {
    private(set) var context = LAContext()
    
    @Published private(set) var biometryTYpe : LABiometryType = .none
    private(set) var canEvaluatePolicy = false
    @Published private(set) var isAuthneticated = false
    @Published private(set) var errorDescription : String?
    @Published var showAlert = false
    
    init() {
        getBiometryType()
    }
    
    func getBiometryType(){
        canEvaluatePolicy = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,error: nil)
        biometryTYpe = context.biometryType
    }
    
    func authenticateWithBiometrics() async {
        context = LAContext()
        
        if canEvaluatePolicy {
            let reason = "Log into your account"
            
            do {
                let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason)
                
                if success {
                    DispatchQueue.main.async {
                        self.isAuthneticated = true
                        print("isAuthenticated",self.isAuthneticated)
                    }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.errorDescription = error.localizedDescription
                    self.showAlert = true
                    self.biometryTYpe = .none
                }
            }
        }
    }
    
    func authenticateWithCredentials(username : String , password:String){
        if username.lowercased() == "stephanie" && password == "123456" {
            isAuthneticated = true
        } else {
            errorDescription = "Wrong credentials"
            showAlert = true
        }
        
    }
    
}

