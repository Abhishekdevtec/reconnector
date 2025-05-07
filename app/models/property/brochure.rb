# frozen_string_literal: true

# Wraps the Property model and provides
# additional functionality when generating
# PDF files.
class Property::Brochure
  include ActiveModel::Model
  include ActiveSupport::NumberHelper
  include ActionView::Helpers::SanitizeHelper

  attr_reader :property

  delegate :images, to: :property
  delegate :short_address, to: :property
  delegate :brochure_disclaimer, to: :account
  delegate :headline, to: :property

  def initialize(property)
    @property = property
  end

  def content
    begin
      # First, generate the HTML content
      html_content = renderer.render(
        format: 'html',  # Render as HTML instead of PDF to debug
        template: 'properties/brochure',
        layout: false,  # Temporarily disable layout to debug
        assigns: { brochure: self }
      )
      
      # Log or save HTML content to debug
      File.open('/tmp/debug_brochure.html', 'w') { |f| f.write(html_content) }
  
      # Now, render the PDF (since you have HTML)
      pdf_content = renderer.render(
        format: 'pdf',
        template: 'properties/brochure',
        type: 'application/pdf',
        layout: false,
        pdf: filename,
        dpi: '300',
        disable_smart_shrinking: true,
        margin: { top: 10, bottom: 10, left: 10, right: 10 },
        delete_temporary_files: false,
        assigns: { brochure: self }
      )
    rescue => e
      Rails.logger.error("Error in rendering PDF: #{e.message}")
      Rails.logger.error(e.backtrace.join("\n"))
      raise e
    end
  
    # Save the generated PDF content (since it's binary data)
    File.open('/tmp/debug_brochure.pdf', 'wb') { |f| f.write(pdf_content) }
  
    pdf_content
  end
  
  

  def export_to(directory)
    save_path = [directory, filename].join('/')
    FileUtils.mkdir_p(directory) unless File.directory?(directory)
    File.open(save_path, 'wb') do |file|
      file << content
    end
  end

  def filename
    return "#{company_name}-#{@property.internal_id}-#{@property.name.parameterize}.pdf" if @property.name.present?
    "#{company_name}-#{@property.internal_id}-#{@property.type.titleize}.pdf"
  end

  def header_background_color
    account.primary_color || '#fff'
  end

  def header_text_color
    '#fff'
  end

  def header_secondary_color?
    account.secondary_color.present?
  end

  def header_secondary_color
    account.secondary_color
  end

  def footer_background_color
    account.primary_color || '#fff'
  end

  def footer_text_color
    '#fff'
  end

  def svg_logo?
    return false unless account.pdf_logo.attached?
    return true if account.pdf_logo.blob.content_type.in? %w[image/svg+xml image/svg]

    false
  end

  def image_logo?
    return false unless account.pdf_logo.attached?
    return false if account.pdf_logo.blob.content_type.in? %w[image/svg+xml image/svg]

    # We assume it's an image
    true
  end

  def logo
    return nil unless account.pdf_logo.attached?

    if account.pdf_logo.blob.content_type.in? %w[image/svg+xml image/svg]
      pdf_logo_as_svg
    else
      # We assume it's an image
      account.pdf_logo
    end
  end

  def property_type_label
    @property.type_label.upcase
  end

  def header_label
    header = @property.try(:contract).try(:lease_sale_label)
    return nil if header.blank?

    header.upcase
  end

  def usages
    @property.usages.collect { |u| I18n.t("activerecord.attributes.property.usages.#{u}") }.join(', ')
  end

  def property_name
    @property.name
  end

  def short_address?
    @property.short_address.present?
  end

  def area_attributes
    attribs = []
    %i[office_area warehouse_area showroom_area storage_area production_area trading_area floor_area land_area].each do |val|
      attribs << [Property.human_attribute_name(val), "#{@property[val]} sqm."] if @property[val].present? && @property[val].positive?
    end
    attribs << ['Building area', "#{@property.building_area} sqm."] if @property.building_area.present? && @property.building_area.positive?
    attribs << ['Hard stand area', "#{@property.hard_stand_yard_area} sqm."] if @property.hard_stand_yard_area.present? && @property.hard_stand_yard_area.positive?
    attribs
  end

  def detail_attributes
    attribs = []
    attribs << [Property.human_attribute_name(:parking_spaces), @property.parking_spaces] if @property.parking_spaces?
    attribs << [Property.human_attribute_name(:zoning), @property.zoning] if @property.zoning&.present?
    attribs << [Property.human_attribute_name(:rating), @property.rating] if @property.rating&.present?
    attribs << [Property.human_attribute_name(:disability_access), @property.disability_access] if @property.disability_access&.present?
    attribs << [Property.human_attribute_name(:entrances_roller_doors_container_access), @property.entrances_roller_doors_container_access] if @property.entrances_roller_doors_container_access&.present?
    attribs << [Property.human_attribute_name(:crane), @property.crane] if @property.crane&.present?
    attribs
  end

  def contract_attributes
    attribs = []
    return attribs unless @property.contract?

    if @property.contract.for_sale?
      attribs << [Contract.human_attribute_name(:sale_price), number_to_currency(@property.contract.sale_actual_sale_price)] if @property.contract.sale_actual_sale_price.present? && @property.contract.sale_actual_sale_price.positive?
    end

    if @property.contract.for_lease?
      attribs << [Contract.human_attribute_name(:lease_total_outgoings), number_to_currency(@property.contract.lease_total_outgoings)] if @property.contract.lease_total_outgoings.present? && @property.contract.lease_total_outgoings.positive?
      attribs << [Contract.human_attribute_name(:lease_total_net_rent), number_to_currency(@property.contract.lease_total_net_rent)] if @property.contract.lease_total_net_rent.present? && @property.contract.lease_total_net_rent.positive?
      attribs << append_lease_total_gross_rent
    end

    attribs.compact_blank
  end

  def brochure_footer
    [@property.agent.name.to_s, @property.agent.mobile, @property.agent.email, account.url].compact_blank.join(' - ')
  end

  def brochure_description
    sanitize(@property.brochure_description.body.to_s.strip, tags: %w[strong i h1 h2 h3 h4 h5 h6 em br ul ol li p])
  end

  private

  def renderer
    ApplicationController.renderer
  end

  def account
    @account ||= @property.account
  end

  def company_name
    account.company_name
  end

  def append_lease_total_gross_rent
    return unless must_display_lease_total_gross_rent?

    [Contract.human_attribute_name(:lease_total_gross_rent), number_to_currency(@property.contract.lease_total_gross_rent)]
  end

  def must_display_lease_total_gross_rent?
    lease_outgoings_and_lease_net_rent? || only_lease_total_gross_rent?
  end

  def lease_outgoings_and_lease_net_rent?
    @property.contract.lease_gross_rent.present? &&
      @property.contract.lease_gross_rent.positive? &&
      @property.contract.lease_outgoings.present? &&
      @property.contract.lease_outgoings.positive?
  end

  def only_lease_total_gross_rent?
    @property.contract.lease_total_gross_rent.present? &&
      @property.contract.lease_total_gross_rent.positive? &&
      !lease_outgoings_and_lease_net_rent?
  end

  def pdf_logo_as_svg
    return nil unless account.pdf_logo.attached?

    account.pdf_logo.open do |file|
      file.read.html_safe
    end
  end

  def content_is_image?(image)
    image.blob.content_type in %w[image/png image/jpg image/jpeg image/gif image/webp]
  end

  def content_is_svg?(image)
    image.blob.content_type in %w[image/svg+xml image/svg]
  end
end
