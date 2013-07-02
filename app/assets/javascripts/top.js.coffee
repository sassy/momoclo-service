# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


google.load("feeds", "1")

blogs = ["http://rssblog.ameba.jp/momota-sd/rss20.xml", "http://rssblog.ameba.jp/tamai-sd/rss20.xml", "http://rssblog.ameba.jp/sasaki-sd/rss20.xml", "http://rssblog.ameba.jp/ariyasu-sd/rss20.xml", "http://rssblog.ameba.jp/takagi-sd/rss20.xml"]

entryCount = blogs.length
entryArray = []

initialize = ->
    for blog in blogs
        feed = new google.feeds.Feed(blog)
        feed.setNumEntries 10
        feed.load ( (result) ->
            if !result.error
                for entry in result.feed.entries
                    if !entry.title.match(/^PR/)
                        index = entryArray.length
                        entryArray[index] = new Array()
                        entryArray[index][0] = Date.parse(entry.publishedDate)
                        entryArray[index][1] = entry.title
                        entryArray[index][2] = entry.contentSnippet
                        entryArray[index][3] = entry.publishedDate
                        entryArray[index][4] = result.feed.title
                        entryArray[index][5] = entry.link
                        if result.feed.link == "http://ameblo.jp/momota-sd/"
                            color = "red"
                        else if result.feed.link == "http://ameblo.jp/tamai-sd/"
                            color = "yellow"
                        else if result.feed.link == "http://ameblo.jp/sasaki-sd/"
                            color = "pink"
                        else if result.feed.link == "http://ameblo.jp/ariyasu-sd/"
                            color = "green"
                        else if result.feed.link == "http://ameblo.jp/takagi-sd/"
                            color = "purple"
                        else
                            color = "undefined"
                        entryArray[index][6] = color
                        
                entryCount--
                if entryCount == 0
                    entryArray.sort()
                    entryArray.reverse()
                    for entryElem in entryArray
                        elemTitle = "<a href=" + entryElem[5]+ "><h2 class=" + entryElem[6] + ">" + entryElem[1] + "</h2></a>"
                        elemContentSnippet = "<div>" +  entryElem[2] + "</div><br>"
                        elemDate = "<div>"+ entryElem[3] + "</div>"
                        elemBlogTitle = "<div>" + entryElem[4] + "</div>"
                        $("#feed").append(elemTitle).append(elemContentSnippet).append(elemDate).append(elemBlogTitle)
        )


google.setOnLoadCallback(initialize)
