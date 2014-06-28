$ ->
  Vue.filter "formatDate", (v) ->
    v.replace /T|Z/g, " "

  content = new Vue
    el: "#content"
    template: "#template"
    data:
      newTweet: "write some tweet."

    created: ->
      if typeof window.preloadedData isnt "undefined"
        @$data = window.preloadedData
        window.preloadedData = null
      else
        $.ajax
          url: "/api/tweets"
          success: (data) =>
            @$data.tweets = data?.tweets


    methods:
      publish: ->
        $.ajax
          type: "POST"
          url: "/api/tweets"
          data:
            content: @$data.newTweet

          dataType: "json"
          success: (tweet) =>
            @$data.tweets.unshift tweet
            @$data.newTweet = ""