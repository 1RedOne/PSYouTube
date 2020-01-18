Function Get-PSYouTubeVideoThumbnail {
    param($video = 'Ks-_Mh1QhMc', $fileName)
    $thumbnailUrl = "https://img.youtube.com/vi/$video/0.jpg"

    Invoke-WebRequest -OutFile .\$fileName -uri $thumbnailUrl 
}
