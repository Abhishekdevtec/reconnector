# app/helpers/meta_tags_helper.rb

module MetaTagsHelper
  def meta_title
    content_for?(:page_title) ? content_for(:page_title) : 'Reconnector.app'
  end
end