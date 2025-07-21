$videoFiles = Get-ChildItem -Path . -Filter *.mkv
$subtitleFiles = Get-ChildItem -Path . -Filter *.srt

foreach ($video in $videoFiles) {
    $episodeNumber = $video.BaseName -replace '.*(S\d+E\d+).*', '$1'
    $matchingSub = $subtitleFiles | Where-Object { $_.Name -match $episodeNumber }
    
    if ($matchingSub) {
        $newSubName = $video.BaseName + ".srt"
        if ($matchingSub.Name -ne $newSubName) {
            Rename-Item -Path $matchingSub.FullName -NewName $newSubName
        }
    }
}

Write-Host "Done!"