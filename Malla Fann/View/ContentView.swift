
import SwiftUI
import CodeScanner
import UIKit



class ContentViewDelegate: ObservableObject{
    @Published var codes: String = ""
   
}


struct ContentView: View {
    
    @ObservedObject var delegate: ContentViewDelegate

    var links : [Link] = []
    
    
    @State var PresentingScannerView = false
    @State var scanQRCode: String = "To get the link just scan the QR Code"
    
    var scanner : some View {
        
        CodeScannerView(codeTypes: [.qr], completion: { result in
            if case let .success(code) = result {
                print(code.string)
          

        
                lazy var  scanQRCode = self.$delegate.codes
                print(scanQRCode)
                self.PresentingScannerView = false
            }
        }
        )
        
    }
    

    
    
    var body: some View{

        VStack() {

            
            Button("Scan QR Code with camera"){
                self.PresentingScannerView = true
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5, opacity: 1))
            .clipShape(Capsule())
            .sheet(isPresented: $PresentingScannerView) {
                self.scanner
                
            }
            Button("Scan QR "){
                self.PresentingScannerView = true
              
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5, opacity: 1))
            .clipShape(Capsule())
            .sheet(isPresented: $PresentingScannerView) {
                self.scanner
                
            }
            

        }
       

    }
    
    

}

struct ContentView_Previews:PreviewProvider{
    static var previews: some View{
        ContentView(delegate: ContentViewDelegate())
        
   
    }
}




