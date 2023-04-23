import Firebase
import GoogleSignIn
import SwiftUI

class LoginService {
    var onFinishedLoggingIn: (() -> Void)?
    var onErrorLoggingIn: (() -> Void)?
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }

    public func goHome() {
        if let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first {
            keyWindow.rootViewController = UIHostingController(rootView: ContentView(viewModel: HomeViewModel(service: Service(), loginService: self)))
            keyWindow.makeKeyAndVisible()
        }
    }
    
    func signout() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
          try Auth.auth().signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func handleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { signResult, error in
                    
            if let error = error {
                self.onErrorLoggingIn?()
               return
            }
                    
             guard let user = signResult?.user,
                   let idToken = user.idToken else { return }
             
             let accessToken = user.accessToken
                    
             let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.onErrorLoggingIn?()
                }
                guard let user = result?.user else {
                    return
                }
                self.onFinishedLoggingIn?()
                withAnimation {
                    self.goHome()
                }
            }
        }
    }
}


