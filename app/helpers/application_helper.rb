module ApplicationHelper
  def pagination_info(item)
    t('.pagination.info',
      :posts => "#{content_tag :strong, "#{item.index(item.first)+item.offset+1}"}&ndash;#{content_tag :strong, "#{item.index(item.last)+item.offset+1}"}",
      :all_posts => content_tag(:strong, item.total_entries)
    )
  end

  def pagination_links(item)
    link_to_if(item.previous_page, t('.pagination.previous_page'), :overwrite_params => {:page => item.previous_page}) +
    ' &mdash; ' +
    link_to_if(item.next_page, t('.pagination.next_page'), :overwrite_params => {:page => item.next_page})
  end
end
