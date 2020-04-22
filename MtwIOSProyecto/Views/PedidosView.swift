//
//  PedidosView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 21/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct PedidosView: View {
    @FetchRequest(entity: Usuario.entity(), sortDescriptors: []) var usuarios: FetchedResults<Usuario>
    @Environment(\.managedObjectContext) var context
    var body: some View {
        VStack {
            List {
                ForEach(usuarios, id: \.self) { usuario in
                    Section(header: Text(usuario.wNombre)) {
                        ForEach(usuario.arrayPedidos, id: \.self) { pedido in
                            VStack{
                                HStack{
                                    Text(pedido.wDescription)
                                    Spacer()
                                    Text("$\(pedido.total, specifier: "%.2f")")
                                }
                                ForEach(pedido.arrayProductos, id: \.self) { producto in
                                    HStack{
                                        Text(producto.wNombre)
                                        Spacer()
                                    }
                                }
                            }
                        }
                    }
                }.onDelete{ index in
                    self.context.delete(self.usuarios[index.first!])
                    try? self.context.save()
                }
            }.onAppear(perform: loadData)
        }
    }
    func loadData() {
    }
}

struct PedidosView_Previews: PreviewProvider {
    static var previews: some View {
        PedidosView()
    }
}
