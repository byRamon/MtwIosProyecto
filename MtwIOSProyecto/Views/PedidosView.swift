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
    var body: some View {
        VStack {
            List {
                ForEach(usuarios, id: \.self) { usuario in
                    Section(header: Text(usuario.wNombre)) {
                        ForEach(usuario.arrayPedidos, id: \.self) { pedido in
                            VStack{
                                Text(pedido.wDescription)
                                ForEach(pedido.arrayProductos, id: \.self) { producto in
                                    Text(producto.wNombre)
                                }
                            }
                        }
                    }
                }
            }.onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        self.usuarios.forEach { usuario in
            print(usuario)
            usuario.arrayPedidos.forEach { pedido in
                print(pedido)
                pedido.arrayProductos.forEach { producto in
                    print(producto.wNombre)
                }
            }
        }
    }
}

struct PedidosView_Previews: PreviewProvider {
    static var previews: some View {
        PedidosView()
    }
}
