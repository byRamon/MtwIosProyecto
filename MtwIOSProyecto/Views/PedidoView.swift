//
//  PedidoView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 21/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct PedidoView: View {
    @FetchRequest(entity: Usuario.entity(), sortDescriptors: []) var usuarios: FetchedResults<Usuario>
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var orden: Orden
    @State private var showingAlert = false
    @State private var mensaje = ""
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
                            if !self.$nombre.wrappedValue.isEmpty && !self.$direccion.wrappedValue.isEmpty && !self.$telefono.wrappedValue.isEmpty{
                                self.hacerPedido()
                            }
                            else {
                                self.mensaje = "Favor de ingresar los datos de contacto"
                                self.showingAlert.toggle()
                            }
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
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Proyecto IOS"), message: Text(self.mensaje), dismissButton: .default(Text("Aceptar")))
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
            if error != nil{
                self.mensaje = "Error al realizar el pedido"
                self.showingAlert.toggle()
                return
            }
            if let data = data{
                if let idPedido = String(data: data, encoding: .utf8) {
                    var uuid = UUID(uuidString: idPedido)
                    //print(uuid)
                    if uuid == nil{
                        self.mensaje = "Error al realizar el pedido"
                        self.showingAlert.toggle()
                        return
                    }
                    self.savePedido(idPedido: idPedido)
                    self.mensaje = "Pedido realizado"
                    self.showingAlert.toggle()
                    self.orden.productos = []
                    return
                }
            }
        }.resume()
    }
    func savePedido(idPedido: String){
        /*self.usuarios.forEach { usuario in
            self.context.delete(usuario)
        }*/
        print("Pedido creado: \(idPedido)")
        var pedido: Pedido?
        var usuario: Usuario?
        orden.productos.forEach { pr in
            let producto = Producto(context: self.context)
            producto.nombre = pr.nombre
            producto.costo = pr.dbCosto()
            producto.descripcion = pr.descripcion
            if pedido != nil{
                producto.pedidos = pedido
            }
            else{
                pedido = Pedido(context: self.context)
                pedido?.descripcion = "Pedido: \(idPedido)"
                pedido?.total = orden.total
                producto.pedidos = pedido
            }
            if(usuario != nil){
                producto.pedidos?.usuario = usuario
            }
            else {
                usuario = Usuario(context: context)
                usuario?.nombre = self.$nombre.wrappedValue
                usuario?.direccion = self.$direccion.wrappedValue
                producto.pedidos?.usuario = usuario
            }
            try? self.context.save()
        }
        print("context guardado")
    }
}

struct PedidoView_Previews: PreviewProvider {
    static let orden = Orden()
    static var previews: some View {
        PedidoView().environmentObject(orden)
    }
}
