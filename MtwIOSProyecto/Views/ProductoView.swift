//
//  ProductoView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 20/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct ProductoView: View {
    @EnvironmentObject var orden: Orden
    var producto : ResultProductos
    var body: some View {
        HStack{
            ImageView(url: producto.thumbnail).overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
            VStack(alignment: .leading){
                HStack{
                    Text(producto.nombre).font(.headline)
                    Spacer()
                    Text("$\(producto.dbCosto(), specifier: "%.2f")")
                }
                HStack{
                    Text(producto.descripcion).font(.caption)
                    Spacer()
                    Button(action: {
                        if self.orden.exist(producto: self.producto) {
                            self.orden.remove(producto: self.producto)
                        }
                        else{
                            self.orden.add(producto: self.producto)
                        }
                    }) {
                        if self.orden.exist(producto: self.producto) {
                            Image(systemName: "cart.badge.minus").foregroundColor(.green)
                        }
                        else{
                            Image(systemName: "cart.badge.plus").foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}

struct ProductoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductoView(producto: ResultProductos.example)
    }
}
