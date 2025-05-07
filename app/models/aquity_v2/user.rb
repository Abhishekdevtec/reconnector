# frozen_string_literal: true
#
# Class which holds data
# from the 'user' table
module AquityV2
  class User < Base
    attribute :id,              :integer, default: nil
    attribute :first_name,      :string,  default: nil
    attribute :last_name,       :string,  default: nil
    attribute :login_name,      :string,  default: nil
    attribute :password,        :string,  default: nil
    attribute :salt,            :string,  default: nil
    attribute :smtp_login_name, :string,  default: nil
    attribute :smtp_password,   :string,  default: nil
    attribute :user_level_id,   :integer, default: nil
    attribute :address,         :string,  default: nil
    attribute :mobile_phone,    :string,  default: nil
    attribute :home_phone,      :string,  default: nil
    attribute :fax_no,          :string,  default: nil
    attribute :email,           :string,  default: nil
    attribute :cr_agency_id,    :string,  default: nil
    attribute :is_active,       :boolean, default: nil
    attribute :is_delete,       :boolean, default: nil
    attribute :created_by,      :integer, default: nil
    attribute :created_date,    :date,    default: nil
    attribute :modified_by,     :integer, default: nil
    attribute :modified_date,   :date,    default: nil

    # Associations
    attr_accessor :user_level
  end
end
