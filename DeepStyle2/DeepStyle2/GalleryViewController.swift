

import UIKit

class GalleryViewController: UIViewController, UITableViewDelegate, CBLUITableDelegate {

    @IBOutlet weak var tableView: UITableView!  //<<-- TableView Outlet
    
    @IBOutlet var dataSource: CBLUITableSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let database = DBHelper.sharedInstance.database
        
        // Create a query sorted by descending date, i.e. newest items first:
        let query = database!.viewNamed("recentJobs").createQuery().asLiveQuery()
        query.descending = true
        
        // Plug the query into the CBLUITableSource, which will use it to drive the table view.
        // (The CBLUITableSource uses KVO to observe the query's .rows property.)
        self.dataSource.query = query
        self.dataSource.labelProperty = "text"    // Document property to display in the cell label
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Customize the appearance of table view cells.
    func couchTableSource(source: CBLUITableSource, willUseCell cell: UITableViewCell, forRow row: CBLQueryRow) {
        cell.textLabel!.font = UIFont(name: "Helvetica", size: 18.0)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
