//
//  SqliteBufferController.swift
//
//  Created by Lawalong on 16/5/16.
//
//

import Foundation

class SqliteBufferContoller: NSObject{
    
    let DATABASE_NAME = "Your SQLite DB name"
    let DATABASE_EXTENSION = "SQLite DB file extention" // Doesn't matter for SQLite
    
    
    /// Check DB, try copy if not exist
    func CheckDataBase(){
        
        Klog("check database...") // log
        
        let url = self.applicationDocumentsDirectory.appendingPathComponent(DATABASE_NAME + "." + DATABASE_EXTENSION)
        
        // Load the existing database
        if !FileManager.default.fileExists(atPath: url.path) {
            Klog("DB not existed, copy one!!!") // log
            
            let sourceSqliteURL = Bundle.main.url(forResource: DATABASE_NAME, withExtension: DATABASE_EXTENSION)!
            let destSqliteURL = self.applicationDocumentsDirectory.appendingPathComponent(DATABASE_NAME + "." + DATABASE_EXTENSION)
            
            do {
                try FileManager.default.copyItem(at: sourceSqliteURL, to: destSqliteURL)
                Klog(self.applicationDocumentsDirectory.appendingPathComponent(DATABASE_NAME + "." + DATABASE_EXTENSION)) // log
            } catch {
                print(error)
            }
            
        }else{
            Klog("DB file exist") // log
            Klog(self.applicationDocumentsDirectory.appendingPathComponent(DATABASE_NAME + "." + DATABASE_EXTENSION))
        }
        
    }
    
    
    /// Get Update, do update if necessary
    func GetDbUpdate(_ version:Int){
        NetworkTools.shareInstance.getUpdataData(version) { (update_result_array,Sversion, error) in
            if error != nil{
                return
            }
            guard let arr = update_result_array else{
                return
            }
            /// Go to update
            if Sversion == 1{
                Klog("db not changed")
                return
            }
            let dbManager = DatabaseManager()
            dbManager.updateProductAndVersion(arr,version: Sversion)
        }
        
    }
    
}
