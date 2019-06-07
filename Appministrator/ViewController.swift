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
    
    
    let usersTableNew = Table("Los estudiantes")
    let id = Expression<Int>("id")
    let name = Expression<String>("nombre")
    let email = Expression<String>("email")
    
    
    //¿Cómo multiplicar las columnas de asistencias sin invocar más líneas de código?
    //let asistencias = Expression<Bool>("asistencias")
    let grupo = Expression<String>("grupo")
    
    //let examen1 = Expression<Int>("primer examen")
    //let tarea1 = Expression<Int>("primer tarea")
    //let examenFinal = Expression<Int>("examen final")
    //let tareaFinal = Expression<Int>("tarea final")
    

    @IBAction func crearTabla(_ sender: UIButton) {
        print("Tabla creada")
        
        let createTable = self.usersTableNew.create{
            (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email)
            table.column(self.grupo)
            //table.column(self.examen1)
            //table.column(self.examenFinal)
            //table.column(self.tarea1)
            //table.column(self.tareaFinal)
            
        }
        
        do {
            try self.database.run(createTable)
            print("La tabla se creó con éxito")
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func crearAlumno(_ sender: UIButton) {
        print("Alumno creado")
        let alert = UIAlertController(title: "Insertar alumno", message: nil, preferredStyle: .alert)
        alert.addTextField {(tf) in tf.placeholder = "Nombre"}
        alert.addTextField {(tf) in tf.placeholder = "Grupo"}
        alert.addTextField{(tf) in tf.placeholder = "Email"}
        let action = UIAlertAction(title: "Submit", style: .default) {(_) in
            guard let name = alert.textFields?[0].text,
                let grupo = alert.textFields?[1].text,
                let email = alert.textFields?.last?.text
                else {return}
            print(name)
            print(grupo)
            print(email)
            let insertUser = self.usersTableNew.insert(self.name <- name, self.grupo <- grupo, self.email <- email)
            do {
                try self.database.run(insertUser)
                print("Alumno ingresado")
            } catch {
                print(error)
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func verAlumnos(_ sender: UIButton) {
        print("Lista de usuarios")
        do{
            let users = try self.database.prepare(self.usersTableNew)
            for user in users{
                print("ID del estudiante: \(user[self.id]), nombre: \(user[self.name]), grupo:\(user[self.grupo]) ,email: \(user[self.email])")
            }
        } catch{
            print(error)
        }
        
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


    var misNombres:[String] = []
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destViewController = segue.destination as? TableController else {return}
        
        var i:Int = 0;
        do{
            let users = try self.database.prepare(self.usersTableNew)
            for user in users{
                misNombres.insert(user[self.name], at: i)
                i = i + 1
            }
            print(misNombres)
        } catch{
            print(error)
        }
        
        destViewController.nombresAlumnosArreglo = misNombres
        print(destViewController.nombresAlumnosArreglo)
        
    }
    
    
    /*
     */
}

