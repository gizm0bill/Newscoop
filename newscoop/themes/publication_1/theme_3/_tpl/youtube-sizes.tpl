
<script type="text/javascript">
window.youtube_min_video_width = 40;
window.youtube_max_video_width = 640;
window.youtube_last_video_width = 640;
window.youtube_video_aspect_ratio = 3.0 / 4.0;

function youtube_adapt_video_sizes(force) {
    var new_video_width = $(window).width() - 20;
    if (window.youtube_min_video_width > new_video_width) {
        new_video_width = window.youtube_min_video_width;
    }

    if (new_video_width > window.youtube_max_video_width) {
        new_video_width = window.youtube_max_video_width;
    }
    if ((new_video_width == window.youtube_last_video_width) && (!force)) {
        return;
    }

    window.youtube_last_video_width = new_video_width;
    $("iframe").each(function(ind_elm, elm) {
        var youtube_src = "http://www.youtube.com/embed/";
        var elm_src = "" + $(elm).attr("src");

        if (youtube_src == elm_src.substr(0, youtube_src.length)) {
            var new_video_height = (new_video_width * window.youtube_video_aspect_ratio) + 0.5;
            new_video_height = parseInt("" + new_video_height);

            $(elm).css("width", new_video_width + "px");
            $(elm).css("height", new_video_height + "px");
        }
    });
};

$(document).ready(function() {
    youtube_adapt_video_sizes(true);
    setInterval("youtube_adapt_video_sizes();", 1000);
});
</script>
