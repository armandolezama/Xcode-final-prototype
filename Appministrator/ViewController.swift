//
//  ViewController.swift
//  Appministrator
//
//  Created by Laboratorio UNAM-Apple on 5/22/19.
//  Copyright © 2019 Laboratorio UNAM-Apple. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {
    
    
    let usersTable = Table("estudiantes")
    let id = Expression<Int>("id")
    let name = Expression<String>("nombre")
    let email = Expression<String>("email")
    
    //¿Cómo multiplicar las columnas de asistencias sin invocar más líneas de código?
    let asistencias = Expression<Bool>("asistencias")
    let grupo = Expression<String>("grupo")
    let examen1 = Expression<Int>("primer examen")
    let tarea1 = Expression<Int>("primer tarea")
    let examenFinal = Expression<Int>("examen final")
    let tareaFinal = Expression<Int>("tarea final")
    
    @IBAction func crearTabla(_ sender: UIButton) {
        print("Tabla creada")
        
        let createTable = self.usersTable.create{
            (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email)
            
        }
        
        do {
            try self.database.run(createTable)
            print("La tabla se creó con éxito")
        } catch {
            print(error)
        }
    }
    
    @IBAction func crearAlumno(_ sender: UIButton) {
        
    }
    
    
    
    var database: Connection!

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            
            let fileUrl = documentDirectory.appendingPathComponent("Tabla de estudiantes").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            
            self.database = database
            
        } catch {
            print(error)
        }
    }


}

