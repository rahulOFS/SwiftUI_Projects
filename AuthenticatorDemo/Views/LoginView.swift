import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationManager : AuthenticationManager
    
    var body: some View {
        VStack(spacing:40) {
            Title()
            
            switch authenticationManager.biometryTYpe {
            case .faceID :
                PrimaryButton(image : "faceid" , text:"Login with FaceID")
                    .onTapGesture {
                        Task.init {
                            await authenticationManager.authenticateWithBiometrics()
                        }
                    }
                
            case .touchID :
                PrimaryButton(image : "touchid" , text: "Login with TouchId")
                    .onTapGesture {
                        Task.init{
                            await authenticationManager
                                .authenticateWithBiometrics()
                        }
                    }
                
            default :
                NavigationLink {
                    CredentialLoginView()
                        .environmentObject(authenticationManager)
                } label :
                {
                    PrimaryButton(image :"person.fill",text:"Login with your credential")
                }
                }
        }
        .frame(maxWidth : .infinity,maxHeight: .infinity)
        .background(LinearGradient(colors : [.blue,.purple],startPoint: .topLeading,endPoint: .bottomTrailing))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationManager())
    }
}
