//
//  ProductoView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 20/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct DetalleTiendaView: View {
    var tienda: ResultTiendas
    @EnvironmentObject var orden: Orden
    @State private var resultProductos = [ResultProductos]()
    @State private var showingAlert = false
    @State private var mensaje = ""
    var body: some View {
        VStack{
            ImageDetailView(url: tienda.imagen)
            VStack{
                Text("Tel: \(tienda.telefono)")
                Text("Dir: \(tienda.ubicacion.lowercased())")
                Text("\(tienda.descripcion)")
            }
            List{
                ForEach(resultProductos, id: \.id){ producto in
                    VStack(alignment: .leading){
                        ProductoView(producto: producto)
                    }
                }
            }.onAppear(perform: loadData).alert(isPresented: $showingAlert) {
            Alert(title: Text("Proyecto IOS"), message: Text(self.mensaje), dismissButton: .default(Text("Aceptar")))
            }
        }.navigationBarTitle(Text(tienda.nombre), displayMode: .inline)
    }
    
    func loadData(){
        guard let url = URL(string: "http://192.168.64.2/ApiProyecto/post.php?productos=true&idtienda=\(tienda.id)")
        else {
            print("invalid Url")
            return
        }
        //print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data{
                do{
                    //let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print(json)
                    let productos = try JSONDecoder().decode([ResultProductos].self, from: data)
                    //print(productos)
                    self.resultProductos = productos
                    return
                }catch{
                    print(error)
                }
            }
            self.mensaje = "Error de conexión"
            self.showingAlert.toggle()
        }.resume()
    }
}

struct DetalleTiendaView_Previews: PreviewProvider {
    static let orden = Orden()
    static var previews: some View {
        NavigationView{
            DetalleTiendaView(tienda: ResultTiendas.example).environmentObject(orden)
        }
    }
}
