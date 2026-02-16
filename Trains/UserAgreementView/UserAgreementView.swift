import SwiftUI

struct UserAgreementView: View {
    @State var viewModel: UserAgreementViewModel
    @Binding var path: [String]
    @State private var isLoading = true
    
    var body: some View {
        ScrollView {
            ZStack {
                Color(Color.background)
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text(Constants.text1)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.accent)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    Text(Constants.text2)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.accent)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    Text(Constants.text3)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(Color.accent)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    Text(Constants.text4)
                        .font(.system(size: 17, weight: .regular))
                        .foregroundStyle(Color.accent)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
            }
        }
        .navigationTitle("Пользовательское соглашение")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    path.removeLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.accent)
                }
            }
        }
    }
}
