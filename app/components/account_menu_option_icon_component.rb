# frozen_string_literal: true
class AccountMenuOptionIconComponent < ViewComponent::Base
  attr_accessor :icon, :active

  def initialize(icon: :none, active: false)
    @icon   = icon
    @active = active
  end

  private

  def classes
    @active ? active_classes : inactive_classes
  end

  def active_classes
    'text-indigo-500 -ml-0.5 mr-2 h-5 w-5'
  end

  def inactive_classes
    'text-gray-400 group-hover:text-gray-500 -ml-0.5 mr-2 h-5 w-5'
  end

  def as_svg
    case @icon
    when :account
      account_svg.html_safe
    when :agents
      agents_svg.html_safe
    when :listings
      listings_svg.html_safe
    when :billing
      billing_svg.html_safe
    when :cog
      cog_svg.html_safe
    end
  end

  def account_svg
    "<svg xmlns=\"http://www.w3.org/2000/svg\" class=\"#{classes}\" viewBox=\"0 0 20 20\" fill=\"currentColor\"><path d=\"M5 4a1 1 0 00-2 0v7.268a2 2 0 000 3.464V16a1 1 0 102 0v-1.268a2 2 0 000-3.464V4zM11 4a1 1 0 10-2 0v1.268a2 2 0 000 3.464V16a1 1 0 102 0V8.732a2 2 0 000-3.464V4zM16 3a1 1 0 011 1v7.268a2 2 0 010 3.464V16a1 1 0 11-2 0v-1.268a2 2 0 010-3.464V4a1 1 0 011-1z\" /></svg>"
  end

  def agents_svg
    "<svg class=\"#{classes}\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 20 20\" fill=\"currentColor\" aria-hidden=\"true\"><path d=\"M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z\" /></svg>"
  end

  def listings_svg
    "<svg xmlns=\"http://www.w3.org/2000/svg\" class=\"#{classes}\" viewBox=\"0 0 20 20\" fill=\"currentColor\"><path fill-rule=\"evenodd\" d=\"M4 4a2 2 0 012-2h8a2 2 0 012 2v12a1 1 0 110 2h-3a1 1 0 01-1-1v-2a1 1 0 00-1-1H9a1 1 0 00-1 1v2a1 1 0 01-1 1H4a1 1 0 110-2V4zm3 1h2v2H7V5zm2 4H7v2h2V9zm2-4h2v2h-2V5zm2 4h-2v2h2V9z\" clip-rule=\"evenodd\" /></svg>"
  end

  def billing_svg
    "<svg class=\"#{classes}\" xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 20 20\" fill=\"currentColor\" aria-hidden=\"true\"><path d=\"M4 4a2 2 0 00-2 2v1h16V6a2 2 0 00-2-2H4z\" /><path fill-rule=\"evenodd\" d=\"M18 9H2v5a2 2 0 002 2h12a2 2 0 002-2V9zM4 13a1 1 0 011-1h1a1 1 0 110 2H5a1 1 0 01-1-1zm5-1a1 1 0 100 2h1a1 1 0 100-2H9z\" clip-rule=\"evenodd\" /></svg>"
  end

  def cog_svg
    "<svg class=\"#{classes}\" xmlns=\"http://www.w3.org/2000/svg\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\" stroke-width=\"2\"><path stroke-linecap=\"round\" stroke-linejoin=\"round\" d=\"M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z\" /><path stroke-linecap=\"round\" stroke-linejoin=\"round\" d=\"M15 12a3 3 0 11-6 0 3 3 0 016 0z\" /></svg>"
  end
end
