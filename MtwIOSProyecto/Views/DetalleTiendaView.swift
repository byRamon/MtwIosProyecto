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
    @State private var resultProductos = [ResultProductos]()
    var body: some View {
        VStack{
            ImageDetailView(url: tienda.imagen).padding()
            Text("Tel: \(tienda.telefono)")
            Text("Dir: \(tienda.ubicacion.lowercased())")
            Text("\(tienda.descripcion)")
            List{
                ForEach(resultProductos, id: \.id){ producto in
                    VStack(alignment: .leading){
                        Text("\(producto.nombre) precio: $\(producto.dbCosto(), specifier: "%.2f")")
                    }
                }
            }.onAppear(perform: loadData).padding()
            
        }.navigationBarTitle(Text(tienda.nombre), displayMode: .inline)
    }
    
    func loadData(){
        guard let url = URL(string: "http://192.168.64.2/ApiProyecto/post.php?productos=true&idtienda=\(tienda.id)")
        else {
            print("invalid Url")
            return
        }
        print(url)
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data{
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    let productos = try JSONDecoder().decode([ResultProductos].self, from: data)
                    print(productos)
                    self.resultProductos = productos
                }catch{
                    print(error)
                }
            }
        }.resume()
    }
}

struct DetalleTiendaView_Previews: PreviewProvider {
    static var previews: some View {
        DetalleTiendaView(tienda: ResultTiendas.example)
    }
}
