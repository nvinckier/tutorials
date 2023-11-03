# Export Content to Illumina Knowledge

## Dependencies

1.  Salesforce CLI (sfdx) installed, running on Linux, or Windows Subsytem for Linux (WSL).
2.  Python 3.6+ installed within same environment as sfdx.


## Update Illumina Knowledge

### Retrieve session cookie

It is necessary to retrieve cookie information for an active login session within a browser in order to download images.

1.  Open a browser and log into Salesforce using the "Log in with Salesforce (DCP)" button.
2.  Open the Network console of Developer tools (`ctrl+shift+I`) for the active browser tab.
3.  Load an image from one of the Knoweldge Base articles in the browser window (e.g. https://illumina.file.force.com/servlet/rtaImage?eid=ka03l000000CAOy&feoid=00N1N00000PINc2&refid=0EM3l000006MRmm).
4.  Export and save the HTML Archive (.har) file as `illumina.file.force.com.har` within the Downloads folder of the current HOME directory `$HOME/Downloads/illumina.file.force.com.har` (e.g. `C:\Users\{username}\Downloads\illumina.file.force.com.har`).

### Execute export script

1.  


https://illumina.gitbook.io/stage-knowledge/TffK7VS5cfsyhjqAdTc5/