# frozen_string_literal: true

# NB Error out if we are not in development mode
unless Rails.env.development?
  puts "[ db/seeds.rb ] Seed data is for development only, not #{Rails.env}"
  exit 0
end

puts '== Creating supported data ==========='
Country.create!(name: 'Australia', country_code: 'AU').tap do |country|
  # States
  country.states.create!(name: 'New South Wales',    abbreviation: 'NSW')
  country.states.create!(name: 'Queensland',         abbreviation: 'QLD')
  country.states.create!(name: 'South Australia',    abbreviation: 'SA')
  country.states.create!(name: 'Tasmania',           abbreviation: 'TAS')
  country.states.create!(name: 'Victoria',           abbreviation: 'VIC')
  country.states.create!(name: 'Western Australian', abbreviation: 'WA')

  # Internal territories
  # https://en.wikipedia.org/wiki/States_and_territories_of_Australia
  country.states.create!(name: 'Australian Capital Territory', abbreviation: 'ACT')
  # country.states.create!(name: 'Jervis Bay Territory', abbreviation: 'ACT') # ???
  country.states.create!(name: 'Northern Territory',           abbreviation: 'NT')
end

# Create at least one Overlord
puts '== Creating Overlords ==================='
Overlord.create!(first_name: 'Grant', last_name: 'Barry', email: 'grant.barry@gmail.com', password: 'password')

# Create an account with an agent and basic settings
puts '== Creating Accounts ===================='
account = Account.create!(
  company_name: 'Griffin Property',
  legal_name: 'Griffin Property',
  domain_name: 'griffinproperty.com.au',
  primary_color: '3c4981',
  secondary_color: '73c92d',
  brochure_disclaimer: 'Disclaimer: This document will not form part of any agreement. Information is provided by outside sources. Griffin Property, its directors, representatives cannot guarantee accuracy, all parties are advised to make their own enquiries. Dimensions are approximate and subject to survey.'
)

account.agents.create!(first_name: 'Grant', last_name: 'Barry', email: 'grant.barry@free.fr', password: 'password')

classifiers = [
  { name: 'Owner' },
  { name: 'Vendor' },
  { name: 'Buyer' },
  { name: 'Landlord' },
  { name: 'Tenant' },
  { name: 'Prospective Tenant' },
  { name: 'Agent' },
  { name: 'Property Manager' },
  { name: 'Tenant Representative' }
]
account.classifiers.insert_all!(classifiers)
