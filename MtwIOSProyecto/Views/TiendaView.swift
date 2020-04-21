//
//  TiendaView.swift
//  MtwIOSProyecto
//
//  Created by ByRamon on 20/04/20.
//  Copyright © 2020 ByRamon. All rights reserved.
//

import SwiftUI

struct TiendaView: View {
    var tienda : ResultTiendas
    var body: some View {
        NavigationLink(destination: DetalleTiendaView(tienda: tienda)){
            HStack{
                ImageView(url: tienda.imagen)
                VStack(alignment: .leading){
                    Section(header: Text(tienda.nombre).font(.headline)){
                        Text("Telefono: \(tienda.telefono)").font(.caption)
                        Text("Ubicacion: \(tienda.ubicacion)".lowercased()).font(.caption)
                    }
                }
            }
        }
    }
}
extension UIImageView {
    func load(ubicacion: String) {
        guard let url = URL(string: ubicacion) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
struct TiendaView_Previews: PreviewProvider {
    static var previews: some View {
        TiendaView(tienda: ResultTiendas.example)
    }
}
