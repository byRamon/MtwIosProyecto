//
//  ContentView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 17/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var resultsTiendas = [ResultTiendas]()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Usuario.entity(), sortDescriptors: []) var usuarios: FetchedResults<Usuario>
    var body: some View {
        NavigationView{
            List{
                ForEach(resultsTiendas, id: \.id){ tienda in
                    VStack(alignment: .leading){
                        TiendaView(tienda: tienda)
                    }
                }
            }.onAppear(perform: loadData)
            .navigationBarTitle("Tiendas")
        }
    }

    func loadData(){
        guard let url = URL(string: "http://192.168.64.2/ApiProyecto/post.php")
        else {
            print("invalid Url")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data{
                //do{let json = try JSONSerialization.jsonObject(with: data, options: [])print(json)}catch{print(error)}
                if let decodedResponse = try? JSONDecoder().decode([ResultTiendas].self, from: data) {
                    DispatchQueue.main.async {
                        self.resultsTiendas = decodedResponse
                        print("RespuestaResponse : .\(decodedResponse)")
                    }
                    return
                }
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
} 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
