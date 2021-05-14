# SharepointVersionDownloader
Script to download all versions of a document on SharePoint

This was created based on the PnP based script located at https://www.sharepointdiary.com/2018/06/sharepoint-online-download-all-versions-using-powershell.html.  I just modified the script to make it easier for end users to run


## To download and run this script
1. Download the script by right clicking this link and select "Save Link As..." or equivalent option in your web browser:  https://raw.githubusercontent.com/n3yne/SharepointVersionDownloader/main/Download-All-Versions-Of-Sharepoint-Document.ps1
2. Save the file to an easily accessible location (such as the desktop)
3. Right click on the saved file and select "Run With Powershell"
    * If you receive an error message that the file is not signed, open the Run dialog (windows key + R) then enter "cmd" (without quotes) and hit OK.  Then type "powershell -executionpolicy bypass " (without quotes, and make sure the last space is there) then drag the file into the command window and hit the Enter key
4. In your web browser, open up sharepoint and navigate to the file you wish to download all versions of.  When you click on the file, it should either show a preview of the file, or give you an option to download the file.  Stop here and copy the full web address from the address bar
5. Switch back to the command prompt window where it is prompting to "Please enter the full URL of the file:" and right click and click paste to paste the full web address.  Hit Enter
6. When it prompts to "Please enter the full path where you wish to download the versions:", enter the full path where you want the files to save at (ex. C:\Temp )
7. The script will go through and download all of the files then open up Windows Explorer to the location where you asked it to save to.
