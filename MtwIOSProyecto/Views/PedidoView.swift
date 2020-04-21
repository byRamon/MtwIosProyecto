//
//  PedidoView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 21/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct PedidoView: View {
    @EnvironmentObject var orden: Orden
    @State private var nombre = ""
    @State private var direccion = ""
    @State private var telefono = ""
    var body: some View {
         NavigationView {
            VStack {
                if orden.productos.count > 0{
                    Section{
                        TextField("Nombre", text: $nombre)
                        TextField("Dirección", text: $direccion)
                        TextField("Telefono", text: $telefono)
                        HStack{
                            Spacer()
                            Text("Total: \(orden.total, specifier: "%.2f")").font(.headline).padding(.trailing)
                        }
                    }.padding(.leading)
                }
                else {
                    Text("Agregue productos al carrito").font(.headline)
                }
                List {
                    ForEach(orden.productos, id: \.id){ producto in
                        VStack(alignment: .leading){
                            ProductoView(producto: producto)
                        }
                    }
                }
                Section {
                    Button(action: {
                        if self.orden.productos.count > 0{
                            self.hacerPedido()
                        }
                        //else{MainView()}
                    }) {
                        if orden.productos.count > 0{
                            HStack{
                                Text("Completar pedido")
                                Spacer()
                                Image(systemName: "paperplane")
                            }.padding().background(Color.green).edgesIgnoringSafeArea(.all)
                        }
                        //else{Text("Añadir productos")}
                    }
                }
            }.navigationBarTitle("Orden").listStyle(GroupedListStyle())
        }
    }
    func hacerPedido(){
        var jsonProductos = ""
        for producto in orden.productos{
            if jsonProductos.count > 0 { jsonProductos += "," }
            jsonProductos += "{\"id\":\"\(producto.id)\"}"
        }
        let jsonData = """
            {"direccion":"\(self.$direccion.wrappedValue)","nombre":"\(self.$nombre.wrappedValue)","telefono":"\(self.$telefono.wrappedValue)","productos":[\(jsonProductos)]}
            """//.data(using: .utf8)!

        guard let url = URL(string: "http://192.168.64.2/ApiProyecto/post.php")
            else {
                print("invalid Url")
                return
            }
        //print("post pedido: \(jsonData)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "pedido=\(jsonData)".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        session.dataTask(with: request){ data, response, error in
            if let response = response{
                print(response)
            }
            if let data = data{
                print("Datos \(data)")
                if let returnData = String(data: data, encoding: .utf8) {
                    print("Respuesta post: .\(returnData)")
                    return
                }
                else {
                    print("")
                }
            }
            }.resume()
    }
}

struct PedidoView_Previews: PreviewProvider {
    static let orden = Orden()
    static var previews: some View {
        PedidoView().environmentObject(orden)
    }
}
