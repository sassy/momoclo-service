# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    url = "https://gdata.youtube.com/feeds/api/videos"
    options =
        "q": "ももいろクローバーZ"
        "alt": "json"
        "max-results": 30
        "v":2

    $.get(url, options, ( (result) ->
        console.log result
        for i in result.feed.entry
            $("#movie_list").append(
                $("<li>").addClass("span4").append(
                    $('<a>').addClass('thumbnail').attr('href', i['media$group']['media$player']['url']).append(
                        $('<img>').attr('src', i['media$group']['media$thumbnail'][2]['url'])
                    )
                ).append(                    
                    $('<div>').text(i['media$group']['media$title']['$t'])
                )
            )
    ), "json")

    