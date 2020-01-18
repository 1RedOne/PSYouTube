
Function Get-PSYouTubeVideoInfo {
    param($video = 'Ks-_Mh1QhMc')    
    $uri = "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=$videoID&key=$key"
    $response = Invoke-RestMethod -Method Get -URI $uri  -ContentType "application/json" 

    return [PSCustomObject]@{
        title = $response.items.snippet.Title;
        createdDate = $response.items.snippet.publishedAt;
        tags = $response.items.snippet.tags;
        views = $response.items.statistics.viewCount;
        description = $response.items.snippet.description;
    }

}