PiWriter is created by Arjan van Lent @ Codejugglers.nl
Licence: BSD (Use and fork as you wish...)

Info:
	PiWriter is a simple GUI app that helps you managing your SD cards for Raspberry Pi.

	Version 1.x uses a wizard that will try to automatically detect your SD card by
	connecting the device at a given time in the process.
	
	Version 2.x uses a drag & drop approach where you drag a mounted disk's desktop
	icon on the application from which it will extract the disk number.

	What version to use is up to you, if you like the drag & drop approach go for PiWriter2.
	If you are scared you might select the wrong disk go for PiWriter 1.x to be 100% sure.

Installation:

Mount the DMG image and drag the .app file inside it to your Applications folder
or some other location you see fit.

Usage PiWriter:

	1) Open PiWriter.app
	2) Select an image file to write to disk
	3) Disconnect your SD (if connected)
	4) Connect SD card when the wizard asks for it
	5) Check if the info in the info window is correct and Start or Quit the cloning process
	6) Wait until PiWriter has finished

Usage PiWriter2:

	1) Open PiWriter2.app
	2) Connect your SD card (if not already connected)
	3) Drag the disk icon from your desktop on the PiWriter2 window
	4) Select mode ("Backup SD" or "Write Image")
	5) Select an image file to write to disk or enter a location and filename to save backup
	  5a) In backup mode: Select compression type to enable gzip compression
	6) Check if the info in the info window is correct and Start or Quit the cloning process
	7) Wait until PiWriter has finished

HOWTO:

	If you'd like to see PiWriter in action before you use it take a look at the following videos:

		The official PiWriter 1.x video: 
			http://vimeo.com/62083666

		Complete PiWriter 1.x HOWTO video by Bruce Fulton:
			http://www.youtube.com/watch?v=PIvNxprbDhQ


Running as Administrator:

Since sometimes devices require administrative access and using a STABLE PIwriter beats using the sudo dd command here's how to achieve this.

	1) Copy PIwriter.app to PIwriter-as-Admin.app
	2) Right click PIwriter-as-Admin.app and select "Show Package Contents"
	3) Navigate to Content/Resources in the Finder window that pops-up
	4) Double click AppSettings.plist. The config editor will open it
	5) Check the box next to 'RequiresAdminPrivileges'
	6) Save the file and your ready to run as Admin
	7) Remember to only run as admin when there is no better option!!



TODO:
	* Integrate PIwriter in upcoming project: ApplePi suite
	* Extend online documentation
	* Make some PiWriter2 tutorial video's (Usage and how to handle devices that require administrative write permissions).


Release Notes:
  2.0.0
	* Total code rewrite
	* Drag and drop disk selection
	* Backup feature (previously PiCloner app)
	* Improved system disk protection

  1.0.4 Final
	* Final release of PiWriter 1
	* Minor changes made to output text
	* Made the donation pop-up less irritating

  1.0.3
	* Added functionality to detect insertion of multi-function devices and prevent those from being selected as SD device.
	* Improved usage of exit and error codes
	* Fixed bug that sometimes caused broken devices to be selected
	* Fixed faulty 'Success!' message when write fails

  1.0.2
	* Fixed bug that caused error when the image path contains spaces.
	* Added extra terminal output to better monitor the process.
	* Polished the script

This Project Is Created Using:
	* PlatyPuss - http://sveinbjorn.org/platypus

This Project Includes:

	* CocoaDialog - http://mstratman.github.com/cocoadialog 

Sources:
	
Checkout the latest development version with GIT.

	git clone git://git.code.sf.net/p/piwriter/code piwriter

In Finder or Terminal navigate to the piwriter folder downloaded by GIT. Right click on
PiWriter.app and select 'Show Package Contents' to browse the code on OS X.
	
