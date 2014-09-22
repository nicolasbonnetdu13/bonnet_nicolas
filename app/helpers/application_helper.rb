module ApplicationHelper
  
  def add_this(options)
    # add google analytics tracking
    url = request.url
    url += url.include?('?') ? '&' : '?'
    url += 'utm_source=add_this&utm_medium=%{provider}'
  
    StaticAddthis.icons(options.reverse_merge(
      :title => @page_title,
      :url => request.request_uri,
      :username => 'bonnet-nicolas',
      :uid => 'ra-541feedd3085aa0f'
    ))
  end

end
