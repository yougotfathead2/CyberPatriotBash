# Define the file types you want to search for
$fileExtensions = @('*.mp3', '*.mp4a', '*.mp4', '*.txt', '*.exe', '*.jpg', '*.png', '*.jpeg')

# Define the directory to search (you can change this to any folder you want)
$searchPath = "C:\Users"

# Optionally, you can define where to output the search results (log file)
$logFile = "C:\search_results.txt"

# Initialize the log file (overwrites if exists)
if (Test-Path $logFile) {
    Remove-Item $logFile
}
New-Item -ItemType File -Path $logFile | Out-Null

# Function to search and log files
function Search-Files {
    param (
        [string[]]$extensions,
        [string]$path,
        [string]$outputLog
    )
    
    foreach ($ext in $extensions) {
        Write-Host "Searching for files with extension: $ext" -ForegroundColor Cyan
        Get-ChildItem -Path $path -Recurse -Filter $ext -ErrorAction SilentlyContinue | ForEach-Object {
            $filePath = $_.FullName
            $fileSize = "{0:N2}" -f ($_.Length / 1MB) + " MB"
            Write-Host "Found: $filePath ($fileSize)" -ForegroundColor Green
            
            # Log the file details into the output log file
            Add-Content -Path $outputLog -Value "$filePath - $fileSize"
        }
    }
    
    Write-Host "Search completed. Results saved to: $outputLog" -ForegroundColor Yellow
}

# Run the search
Search-Files -extensions $fileExtensions -path $searchPath -outputLog $logFile
