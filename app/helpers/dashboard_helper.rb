module DashboardHelper
  def youtube_embed(video)
    
    return display_youtube_videos(g_video)
  end
  
  def display_youtube_videos(_videos)
    if !_videos.blank?
            html = ""
            html += "<div id='videoplay'>"
            html += "<object width=\"385\" height=\"344\"><param name=\"movie\" value=\""+_videos.videos.first.embed_url+"\"</param><param name=\"allowFullScreen\" value=\"true\"></param><embed src=\""+_videos.videos.first.embed_url+"\" type=\"application/x-shockwave-flash\"  allowfullscreen=\"true\"  width=\"385\" height=\"344\"></embed></object>"
            html +="</div><ul id=\"youtubelist\" class=\"mediaList\">"
                _videos.videos.each do |v|
              html += "<li onclick=\"display_video_player('#{v.embed_url}');\">"+image_tag(v.thumbnails.first.url)+"</li>"
                end
                html += "</ul>"
    else
            html = "<div id='emptyYoutube'>No related videos were found</div>"
    end
                    return html
  end
end

