import SwiftUI

struct ContentView: View {
    @StateObject  var authenticationManager = AuthenticationManager()
    
    var body: some View {
        NavigationView {
            VStack {
                if authenticationManager.isAuthneticated{
                    VStack(spacing: 40){
                        Title()
                        Text("Welcome in! You are now authenticated.")
                            .foregroundColor(.white)
                        
                        PrimaryButton(
                            showImage : false,
                            text: "Logout")
                            .onTapGesture {
                                
                            }
                    }
                   
                }
                else{
                    LoginView()
                        .environmentObject(authenticationManager)
                }
               
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $authenticationManager.showAlert){
                Alert(title:Text("Error"),message : Text(authenticationManager.errorDescription ?? "Error trying to login with credentials,please try again"),dismissButton: .default(Text("Ok")))
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
