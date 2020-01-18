# YouTube API Project

##Trigger Warning : I discuss eating disorder related conent and my opinions on it briefly in this post.  If this content is difficult for some, I recommend scroll past **The Background** and resuming at **The Project** instead.

## Background 

I ❤ YouTube.  I have learned so much about development from folks like I am Tim Curry, or from the amazing Microsoft Virtual Academy courses from Jeffrey Snover and Jason Helmick.  Most days I catch the repeats from the Cobert Report, and then jam out to synthwave or chillhop.  I listened to one particualr playlist so many times while learning c# that I still get flashbacks when I hear the songs on it again...sleepness nights trying to uncover everything I don't know.  I even have my own YouTube Video too that I think my mom watched 70,000 times.  

My kids grew up singing songs from Dave and Eva, Little Baby Bum, Super Simple Songs and now Rachel and the TreeSchoolers, and it was one of the first services I signed up for and still pay for today (aside from NetFlix, and that one stint where I got CDs through the mail, yeah...)

But a few months ago I read about the sort of content people report that YouTube pushes into the feeds of viewers, including pro eating-restriction and bulimia content.  I have a history with people who experience these disorders and want to be sure we face it head on in my family, but also do not allow impressionable minds to be exposed to content which presents this issue in a positive light.  

## The Project

So I wanted to see which sorts of videos YouTube will recommend as a user continues to watch videos on their site.  I was curious to see what woudl emerge from a few entry points:

* Girls Fashin
** Video One
** Video One
** Video One
* Seed Video Two
** Video One
** Video One
** Video One
* Seed Video Three 

For each of these I would traverse about 250 videos deep.  We would retrieve the video details, the thumbnails, and also the top five related videos.

## Getting set up 
Setting up a YouTube API account is very simple.  You can sign up here.  Notice how there is no credit card link?  Interestingly from what I could tell, thee is no cost to working with the YoUTube API.  But that is not to say that it's unlimited.  YouTube uses a Quota based program where you have 10,000 units of quota to spend a day on the site.  Sounds like a lot but it is *really* not when doing research.

Operation, Quota Cost, Description
Get Video Details, ?, retrieves info on the video, the creator, and also the tags and the desciption. 
Get Related Videos, ?, retrieves 99 related videos
Get Video Thumbnail, 0*, retrieves the thumbnail of a video given the videoID

I hit my quota cap within moments and so had to run my data gathering over the course of a few days.


* links to articles on topics
* links to other companies pledges to remove this info
* background on why I care

## How YouTube API Works 

Needed Functions

### Do next

* add video link field to Get-YouTubeVideoInfo function
* create script to download video info with a small delay
* dump output into spreadsheet and datamine
* cleanup code into module
* finish blog post 

### Done
* get related videos
* Get Video Info
* Get Video Thumbnail

#### Get video info

What we need
* video title,
* video link,
* video thumbnail,
* video tags (like #beauty, #teens),

##### thumbnail
https://stackoverflow.com/questions/2068344/how-do-i-get-a-youtube-video-thumbnail-from-the-youtube-api

#### get related video
````
SA  https://stackoverflow.com/questions/19725950/youtube-related-videos-using-youtube-v3-api
DOC https://developers.google.com/youtube/v3/docs/search/list
GET https://www.googleapis.com/youtube/v3/search?part=snippet&relatedToVideoId=5rOiW_xY-kc&type=video&key={YOUR_API_KEY}
````

start with three seed videos
for each, get five recommended videos 
    for each of these fifteen
        get five recommended videos 
            for each of these 75 videos 
                get three recommended videos
                  AND 
                Add all to a list

THEN

for each of these 225 videos
    get: {
            video title,
            video link,
            video thumbnail,
            video tags (like #beauty, #teens),
    } and with these...

        add row to a spreadsheet with title, link, and tags for each videos
            and
        dump thumbnail to folder for easy browsing