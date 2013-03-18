PiWriter is created by Arjan van Lent @ Codejugglers.nl
Licence: BSD (Use and fork as you wish...)

Installation:

Mount the DMG image and drag the .app file inside it to your Applications folder
or some other location you see fit.

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
	* ?? Add an extra mode in which the user can manually set the SD device to be used.
	* Extend online documentation
	* Make some tutorial video's on how to handle devices that require administrative write permissions.

Release Notes:

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
	
