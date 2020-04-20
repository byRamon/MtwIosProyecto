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
        VStack {
            List {
                ForEach(usuarios, id: \.self) { usuario in
                    Section(header: Text(usuario.wNombre)) {
                        ForEach(usuario.arrayPedidos, id: \.self) { pedido in
                            Section(header: Text(pedido.wDescription)) {
                                ForEach(pedido.arrayProductos, id: \.self) { producto in
                                    Text(producto.wNombre)
                                }
                            }
                        }
                    }
                }
            }
            List{
                ForEach(resultsTiendas, id: \.id){ item in
                    VStack(alignment: .leading){
                            Text(item.nombre).font(.headline)
                            Text(item.telefono)
                    }
                }
            }
            
            Button("Post"){
                var json = """
                  {"direccion":"Junco 120","nombre":"Ramon","telefono":"4561014583","productos":[{"id":"f24cdff3-80b8-11ea-be14-94e979ecb4f6"},{"id":"bb64adc6-80b8-11ea-be14-94e979ecb4f6"}]}
                """//.data(using: .utf8)!
                
                guard let url = URL(string: "http://192.168.64.2/ApiProyecto/post.php")
                    else {
                        print("invalid Url")
                        return
                    }
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = "pedido=\(json)".data(using: String.Encoding.utf8)
                let session = URLSession.shared
                session.dataTask(with: request){ data, response, error in
                    if let response = response{
                        print(response)
                    }
                    if let data = data{
                        print("Datos \(data)")

                        if let returnData = String(data: data, encoding: .utf8) {
                          print(returnData)
                            return
                        } else {
                          print("")
                        }
                    }
                }.resume()
                
            }
            Button("Api"){
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
            Button("Add") {
            
                self.usuarios.forEach { usuario in
                    self.context.delete(usuario)
                }
                
                let producto = Producto(context: self.context)
                producto.nombre = "Sabritas"
                producto.descripcion = "Bolsa de papas"
                producto.costo = 20
                producto.pedidos = Pedido(context: self.context)
                producto.pedidos?.descripcion = "Pedido 1"
                producto.pedidos?.total = 20
                producto.pedidos?.usuario = Usuario(context: self.context)
                producto.pedidos?.usuario?.nombre = "Ramon"
                producto.pedidos?.usuario?.direccion = "junco"
                producto.pedidos?.usuario?.telefono = "4561014583"
                
                let producto2 = Producto(context: self.context)
                producto2.nombre = "Sabritones"
                producto2.descripcion = "Bolsa de botana"
                producto2.costo = 20
                producto2.pedidos = producto.pedidos
                producto2.pedidos?.usuario = producto.pedidos?.usuario
                
                
                let producto3 = Producto(context: self.context)
                producto3.nombre = "Galletas saladas"
                producto3.descripcion = "Galletas gamesa"
                producto3.costo = 30
                producto3.pedidos = Pedido(context: self.context)
                producto3.pedidos?.descripcion = "Pedido 2"
                producto3.pedidos?.total = 60
                producto3.pedidos?.usuario = Usuario(context: self.context)
                producto3.pedidos?.usuario?.nombre = "Luis"
                producto3.pedidos?.usuario?.direccion = "junco"
                producto3.pedidos?.usuario?.telefono = "4561014583"
                
                let producto4 = Producto(context: self.context)
                producto4.nombre = "Atun"
                producto4.descripcion = "Atún herdez"
                producto4.costo = 30
                producto4.pedidos = producto3.pedidos
                producto4.pedidos?.usuario = producto3.pedidos?.usuario
                
                try? self.context.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
