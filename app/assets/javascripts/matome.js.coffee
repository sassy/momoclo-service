# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

google.load("feeds", "1")

blogs = ["http://momoclomatome.com/atom.xml", "http://momo96ch.com/atom.xml","http://momoclosokuhou.2chblog.jp/atom.xml", "http://blog.livedoor.jp/momomaton/atom.xml"]

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
                        
                entryCount--
                if entryCount == 0
                    entryArray.sort()
                    entryArray.reverse()
                    for entryElem in entryArray
                        elemTitle = "<a href=" + entryElem[5]+ "><h2>" + entryElem[1] + "</h2></a>"
                        elemContentSnippet = "<div>" +  entryElem[2] + "</div>"
                        elemDate = "<div>"+ entryElem[3] + "</div>"
                        elemBlogTitle = "<div>" + entryElem[4] + "</div>"
                        $("#feed_matome").append(elemTitle).append(elemContentSnippet).append(elemDate).append(elemBlogTitle)
        )


google.setOnLoadCallback(initialize)
