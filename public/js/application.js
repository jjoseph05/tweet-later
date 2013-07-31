$(document).ready(function() 
{
    $('#loading_gif').hide();
    
    $('form').on('submit', function(event){
        event.preventDefault();

        $('#loading_gif').show(100);
        $('#submit_button').unbind(); // remove clicrkability to subimit button 

        // var user = $('#user').text();
        var url           = "/send_tweet";
        var tweet_content = $(this).serialize();

        // console.log(url + "\n" + tweet_content);

        $.post(url, tweet_content, function(response)
        {
            $('#loading_gif').replaceWith("<p id='message' style='color:blue;'>Tweet Sent</p>");
            $('#submit_button').bind('click', function(){}); // restore clickability to subimit button 
        });
    });
});


