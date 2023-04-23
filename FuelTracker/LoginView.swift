
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Image("login")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: getRect().height / 3)
                .background(
                Circle()
                    .fill(Color.white)
                    .scaleEffect(1.67)
                )
            Spacer()
            Text("Welcome to FuelApp! Please, sign in to use the app")
                .bold()
            Button {
                viewModel.login()
            } label: {
                HStack {
                    Image("google")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .aspectRatio(contentMode: .fit)
                    Text("Sign in")
                        .foregroundColor(.black)
                        .font(.title2)
                        .fontWeight(.medium)
                }
            }
            .padding()
            .buttonStyle(.bordered)
            .tint(.white)
            .clipShape(Capsule())
            Spacer()

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.greenBackground)
        .navigationBarBackButtonHidden(true)
        .overlay {
            if viewModel.isLoading {
                Color.black
                    .opacity(0.25)
                    .ignoresSafeArea()
                ProgressView()
                    .font(.title2)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(service: LoginService()))
    }
}
