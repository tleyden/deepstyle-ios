

import UIKit

class GalleryViewController: UIViewController, UITableViewDelegate, CBUITableDelegate, PresenterViewController, SourceAndStyleImageReciever {

    @IBOutlet weak var tableView: UITableView!  //<<-- TableView Outlet
    
    @IBOutlet var dataSource: CBUITableSource!
    
    var presenterViewController: PresenterViewController? = nil
    
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
        
        
        do {
            print("num docs in db \(database!.documentCount)")
            let queryEnum = try query.run()
            while let nextRow = queryEnum.nextRow() {
                print("nextRow: \(nextRow) doc: \(nextRow.document)")
            }
        } catch {
            print("error running query: \(error)")
        }
        
        
        let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "logout:")
        self.navigationItem.leftBarButtonItem = logoutButton;
        
        let addDeepStyleButton = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "addDeepStyle:")
        self.navigationItem.rightBarButtonItem = addDeepStyleButton;
        
        self.tableView.registerNib(UINib(nibName: "GalleryTableViewCell", bundle: nil), forCellReuseIdentifier: "GalleryTableViewCell")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logout(sender: UIBarButtonItem) {
        print("logout")
        presenterViewController?.dismiss()
    }
    
    func addDeepStyle(sender: UIBarButtonItem) {
        
        let addDeepStyle = AddDeepStyleViewController()
        
        // register ourselves as the presenter view controller delegate, so we get called back
        // when this view wants to get rid of itself
        addDeepStyle.presenterViewController = self
        
        // get called back with UIImages that the user chose
        addDeepStyle.sourceAndStyleReceiver = self
        
        let nav = UINavigationController(rootViewController: addDeepStyle)
        self.presentViewController(nav, animated: true, completion: nil)
        
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dismissWithImages(sourceImage: UIImage, styleImage: UIImage) throws {
        print("todo, process images")
        
        let deepStyleJob = try DBHelper.sharedInstance.createDeepStyleJob(sourceImage, styleImage: styleImage)
        print("DeepStyleJob: \(deepStyleJob)")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func couchTableSource(source: CBUITableSource, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GalleryTableViewCell", forIndexPath: indexPath) as! GalleryTableViewCell
        return cell
    }
    
    // Customize the appearance of table view cells.
    func couchTableSource(source: CBUITableSource, willUseCell cell: UITableViewCell, forRow row: CBLQueryRow) {
        
        let galleryCell = cell as! GalleryTableViewCell
        cell.textLabel!.font = UIFont(name: "Helvetica", size: 18.0)
        
        let job = lookupJobForQueryRow(row)
        
        if let styleImage = job.styleImage() {
            galleryCell.paintingImageView!.image = styleImage
        }
        
        if let sourceImage = job.sourceImage() {
            galleryCell.photoImageView!.image = sourceImage
        }

        switch job.state! {
        case DeepStyleJob.StateReadyToProcess:
            galleryCell.finishedImageView!.image = UIImage(named: "transit-icon")
        case DeepStyleJob.StateProcessingSuccessful:
            if let finishedImage = job.finishedImage() {
                galleryCell.finishedImageView!.image = finishedImage
            }
        default:
            galleryCell.finishedImageView!.image = UIImage(named: "icon-gear")
        }

        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 87.5
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // CBLQueryRow *row = [self.dataSource rowAtIndex:indexPath.row];
        if let row = self.dataSource.rowAtIndexPath(indexPath) {
            let job = lookupJobForQueryRow(row)
            
            let jobViewController = DeepStyleJobViewController()
            jobViewController.setJob(job)
            
            self.navigationController?.pushViewController(jobViewController, animated: true)
        }
        
    }
    
    func lookupJobForQueryRow(row: CBLQueryRow) -> DeepStyleJob {
        let doc = row.document
        print("doc id: \(doc?.documentID)")
        return DeepStyleJob(forDocument: doc!)
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
