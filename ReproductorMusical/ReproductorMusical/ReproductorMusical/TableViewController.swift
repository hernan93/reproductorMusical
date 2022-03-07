//
//  TableViewController.swift
//  ReproductorMusical
//
//  Created by XCode on 15/12/2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    var mp3FileNames = ["Canciones"]
    var mp3Files: [URL] = []
    
    let vinil = UIImage(named: "checkB.png")
        
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
       
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentsPath.path)// truco para saber dónde está en el simulador

        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsPath, includingPropertiesForKeys: nil)

            // Filtar el contenido para cargar solo archivos mp3
           mp3Files = directoryContents.filter{ $0.pathExtension == "mp3" }
            //Cargar en la lista solo nombre de la música
            mp3FileNames = mp3Files.map{ $0.deletingPathExtension().lastPathComponent }
           // print("mp3 list:", mp3FileNames) //imprime lista de canciones

        } catch {
            print(error)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mp3FileNames.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the
        
        cell.textLabel?.text = "🎶 \(mp3FileNames[indexPath.row])"

     return cell
    }
     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "LISTA DE CANCIONES"
     }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            // Delete the row from the data source
        mp3FileNames.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        allfiles.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewController
        if vc.view != nil {
            if tableView.indexPathForSelectedRow!.section == 0 {
                vc.nombre_cancion = mp3FileNames[tableView.indexPathForSelectedRow!.row]
                vc.cancion = tableView.indexPathForSelectedRow!.item
                vc.mp3File = mp3Files[tableView.indexPathForSelectedRow!.item]
                vc.mp3Filesarchivos = mp3Files
                vc.mp3FileNombres = mp3FileNames
                
                
                 // Get the new view controller using segue.destination.
                 // Pass the selected object to the new view controller.
            }
        
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        

        
    }
    
    
    
    
}
