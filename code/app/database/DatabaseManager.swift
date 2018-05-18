//
//  DatabaseManager.swift
//
//  Created by KevinLi on 16/7/11.
//

import UIKit

class DatabaseManager {
    
    let DATABASE_NAME = "Your SQLite DB name"
    let DATABASE_EXTENSION = "SQLite DB file extention" // Doesn't matter for SQLite
    
    fileprivate var database:FMDatabase!
    
    init() {
        openDatabase()
    }
    
    /// open DB
    func openDatabase() {
        
        
        let dbPath = self.applicationDocumentsDirectory.appendingPathComponent(DATABASE_NAME + "." + DATABASE_EXTENSION).absoluteString
        
                let resourcePath = NSBundle.mainBundle().resourceURL!.absoluteString
                let dbPath = (resourcePath as NSString).stringByAppendingPathComponent(DATABASE_NAME + "." + DATABASE_EXTENSION)
        
        let database = FMDatabase(path: dbPath)
        
        
        /* Open database read-only. */
        if (!(database.open(withFlags: SQLITE_OPEN_READWRITE))) {
            print("Could not open database at \(dbPath).")
        } else {
            Klog("open database success")
            self.database = database;
        }
    }
    
    /// close DB
    func closeDatabase() {
        if (database != nil) {
            database.close()
        }
    }
    
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.appcoda.CoreDataDemo" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    

    
    /// Check DB Version
    func checkDbVersion() -> Int {
        let queryString: String = "select max(version) from source_version where ?"
        if let db = database, let q = db.executeQuery(queryString, withArgumentsIn: ["1"]){
            var version = 1
            while q.next(){
                version = Int(q.string(forColumn: "max(version)")!)!
            }
            return version
        }
        return 1
    }
    
    /// upDateProduct & versionControl data
    func updateProductAndVersion(_ updateArray:[UpDateItem],version:Int) -> Bool{
        var flag = false
        let SQL_INSERT = "INSERT OR IGNORE INTO source VALUES (?,?,?,?,?,?)"
        let SQL_UPDATE = "UPDATE product SET price = ? WHERE id LIKE ?"
        let SQL_UPDATE_VERSION = "insert into version_control (version) values (?)"
        
        for updateitem:UpDateItem in updateArray{
            // your query
        }
        if let db = database, let q = db.executeQuery(SQL_UPDATE_VERSION,withArgumentsIn:[version]){
            while q.next(){}
            Klog("version control changing success")
            flag = true
        }
        else {
            flag = false
        }
        return flag
    }
    
    
}






