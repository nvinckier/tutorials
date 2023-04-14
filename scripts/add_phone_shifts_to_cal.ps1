echo "Updating Outlook with phone shifts from When I Work"
# Download the .ics from When I Work
curl -o "$HOME\Documents\phone_shifts.ics" 'http://app.wheniwork.com/calendar/b61f18497a3711cd685f83f71bb8b335ea76e189.ics'

# Find all line numbers for the start of each event
$startLines = (Get-Content "$HOME\Documents\phone_shifts.ics" | Select-String "BEGIN:VEVENT").LineNumber

# Create folder to stash each .ics files generated for each individual event
$icsPath ="$HOME\Documents\phone_shifts"
# Setting the command equal to $null supresses terminal output
$null = New-Item -Path "$icsPath" -ItemType Directory -force

foreach ($line in $startLines) {
	Get-Content "$HOME\Documents\phone_shifts.ics" | select -skip ($line -1) | select -First 18 > "$icsPath\$line.ics" }

$icsList = get-childitem $icsPath

# Clear out old appointments to avoid duplicates.
$outlook = new-object -com Outlook.Application
$calendar = $outlook.Session.GetDefaultFolder(9)
$itemsToBeDeleted = $calendar.Items | Where-Object { $_.Categories -eq 'Get Shwifty' }
# Check if any appointments matching the category above are present and then delete them. If no matches are found this will avoid attempting to perform a delete operation on a null, thus avoiding an error
if($itemsToBeDeleted -ne $null){
	$itemsToBeDeleted.Delete()
}

foreach ($i in $icsList ){
	$file = $i.fullname
	$data = @{}
	$content = Get-Content $file -Encoding UTF8
	$content | foreach-Object {
		if($_.Contains(':')){
			$z=@{ $_.split( ':')[0] =( $_.split( ':')[1]).Trim()}
			$data. Add( $z. Keys, $z. Values)
		}
	}
	$outlook = new-object -com Outlook.Application
	$calendar = $outlook.Session.GetDefaultFolder(9) 
	$appt = $calendar.Items.Add(1)

	# The body spacing/encoding was a PAIN, excuse the ugliness.
	$Body = [regex]::match($content,'(?<=\DESCRIPTION:).+(?=\DTEND:)', "singleline").value.trim()
	$Body = $Body -replace "\r\n\s"
	$Body = $Body.replace("\,",",").replace("\n"," ")
	$Body = $Body -replace "\s\s"

	# Useful for debugging
	# echo $Body

	$Start = ($data.getEnumerator() | ?{ $_.Name -eq "DTSTART"}).Value -replace "T" -replace "Z"
	$Start = [datetime]::ParseExact($Start ,"yyyyMMddHHmmss" ,$null ).AddSeconds(-25200)

	# Useful for debugging
	# echo $Start

	$End = ($data.getEnumerator() | ?{ $_.Name -eq "DTEND"}).Value -replace "T" -replace "Z"
	$End = [datetime]::ParseExact($End ,"yyyyMMddHHmmss" ,$null ).AddSeconds(-25200)

	# Useful for debugging
	# echo $End

	$Subject = ($data.getEnumerator() | ?{ $_.Name -eq "SUMMARY"}).Value

	# Useful for debugging
	# echo $Subject
	$Location = ($data.getEnumerator() | ?{ $_.Name -eq "LOCATION"}).Value

	# Useful for debugging
	# echo $Location

	$appt.Start = $Start
	$appt.End = $End
	$appt.Subject = "$Subject"
	$appt.Location = "$Location"
	$appt.Categories = "Get Shwifty" #Pick your own category! Don't forget to change it above where the old items are removed prior to adding new items.
	$appt.BusyStatus = 2	# 0=Free 1=Tentative 2=Busy 3=Out of Office 4=Working Elsewhere
	$appt.Body = $Body
	$appt.ReminderMinutesBeforeStart = 20 #Customize if you want 

	# Save the appointment to the calendar5
	$appt.Save()

	# Prints a message to the terminal indicating whether the appointment was saved or not, useful for debugging
	# if ($appt.Saved){
	# 	write-host "Appointment saved."}
	# Else {write-host "Appointment NOT saved."}
}

# Remove the temporary phone_shifts folder and the phone_shifts.ics.
del $icsPath -Recurse -Force
del "$HOME\Documents\phone_shifts.ics" -Recurse -Force