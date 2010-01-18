module ApplicationHelper
  def paginate(item, items)
    page_first_item = items.index(items.first) + items.offset + 1
    page_last_item  = items.index(items.last)  + items.offset + 1

    page_items = [content_tag(:strong, page_first_item), content_tag(:strong, page_last_item)].join('&ndash;')
    all_items  = content_tag(:strong, items.total_entries)

    previous_page_link = link_to_if(items.previous_page, t('pagination.previous_page'), :overwrite_params => {:page => items.previous_page})
    next_page_link     = link_to_if(items.next_page,     t('pagination.next_page'),     :overwrite_params => {:page => items.next_page})

    info  = t('pagination.info', :item => item, :items => page_items, :all_items => all_items)
    links = [previous_page_link, next_page_link].join(' &mdash; ')

    [info, links].join(tag(:br))
  end
end
