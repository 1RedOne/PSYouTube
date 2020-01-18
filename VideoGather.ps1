#start https://console.developers.google.com/apis/dashboard?project=youtubegirlsvidsapi&pageState=(%22duration%22:(%22groupValue%22:%22PT1H%22))
#quota usage https://console.developers.google.com/apis/api/youtube/quotas?project=youtubegirlsvidsapi&duration=PT1H
if (!(gmo PSYouTube)){
    "importing module"
    import-module C:\git\PSYouTube -Verbose
}else{
    "module already imported..."
}
$videoIDArray = New-Object System.Collections.ArrayList
$videoInfoArray = New-Object System.Collections.ArrayList

$seedVideo = @("Jhq23NKsjjg",
    "fXuVdz6nlHg",
    "ml2E8TnU"
)
Write-Output "Found $($seedVideo.Count) seed videos"
ForEach($video in $seedVideo  ){
    $thisrelatedVideo = Get-PSYouTubeRelatedVideo -VideoID $video
    $relatedVideos+= $thisrelatedVideo
    start-sleep -Milliseconds 250
}

Write-Output "Found $($relatedVideos  | select -expand videoID -Unique | measure  | Select-Object -ExpandProperty Count) videos"
ForEach($video in $relatedVideos  | select -expand videoID -Unique -first 25 -skip 150){
    $relatedVideos += Get-PSYouTubeRelatedVideo -VideoID $video
    start-sleep -Milliseconds 350   
}

Write-Output "Found $($relatedVideos  | select -expand videoID -Unique | measure  | Select-Object -ExpandProperty Count) videos"
ForEach($video in $relatedVideos  | select -expand videoID -Unique  ){
    $relatedVideos += Get-PSYouTubeRelatedVideo -VideoID $video
    start-sleep -Milliseconds 500
}

Write-Output "Found $($relatedVideos  | select -expand videoID -Unique | measure  | Select-Object -ExpandProperty Count) videos"
ForEach($video in $relatedVideos  | select -expand videoID -Unique  ){
    if ($video -eq $null){"empty, skipping";continue}
    start-sleep -Milliseconds 1200
    try{
        $videoInfo = Get-PSYouTubeVideoInfo -video $video -ErrorVariable errvar 
    }
    catch{
        "error $($errvar)"
        continue
    }
    "adding video thumbnail for $($videoInfo.title)"
    Get-PSYouTubeVideoThumbnail -video $video -fileName $videoInfo.title
    [void]$videoInfoArray.Add($videoInfo)
}
$shortDate = "$([DateTime]::Now.ToShortDateString().Replace('/','-'))-$([DateTime]::Now.ToLongTimeString().Replace(':','_').Replace(' ',$null))"
$relatedVideos | ConvertTo-Json | out-file .\"$($shortDate)-VideoIDs.json"
$videoInfoArray | ConvertTo-Json | out-file .\"$($shortDate)-InfoOutput.json"