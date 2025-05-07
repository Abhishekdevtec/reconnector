module PdfHelper
  def embed_image(asset)
    data = asset.blob.download
    content_type = asset.blob.content_type
    base64 = Base64.encode64(data.to_s).gsub(/\s+/, '')
    "data:#{content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
