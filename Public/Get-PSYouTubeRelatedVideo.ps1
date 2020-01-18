Function Get-PSYouTubeRelatedVideo {
    param($VideoID= 'Ks-_Mh1QhMc')
    begin{
        if (-not $global:PSYouTubeclientSecret){
            "need to run Connect-PSYouTubeAccount first!"
            break
        }
        else{
            $key = Get-DecryptedValue $global:PSYouTubeclientSecret
        }
    }
    process{        
        $uri = "https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=$VideoID&type=video&key=$key&maxResults=5"
        $response = Invoke-RestMethod -URI $URI -Verbose:$false
        return $response.items.id | Select-Object videoId
    }
    end{}
}