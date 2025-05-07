namespace :aquity_v2 do
  # Imports a JSON database from from Aquity V2
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import Aquity JSON database dump'
  task import: :environment do
    filename = Rails.root.join('input', 'aquity_v2', 'import.json')
    import = AquityV2Services::JsonImport.new(filename)
    import.import
  end

  # Imports agents from an Aquity V2
  # database dump in JSON format
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import agents from Aquity JSON database dump'
  task import_agents: :environment do
    filename = Rails.root.join('input', 'aquity_v2', 'import.json')
    import = AquityV2Services::JsonImport.new(filename)
    import.import_agents
  end

  # Imports contacts from an Aquity V2
  # database dump in JSON format
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import contacts from Aquity JSON database dump'
  task import_contacts: :environment do
    filename = Rails.root.join('input', 'aquity_v2', 'import.json')
    import = AquityV2Services::JsonImport.new(filename)
    import.import_contacts
  end

  # Imports properties from an Aquity V2
  # database dump in JSON format
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import properties from Aquity JSON database dump'
  task import_properties: :environment do
    filename = Rails.root.join('input', 'aquity_v2', 'import.json')
    import = AquityV2Services::JsonImport.new(filename)
    import.import_properties
  end

  # Imports property images from an Aquity V2
  # database dump in JSON format
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import property_images from Aquity JSON database dump'
  task import_property_images: :environment do
    filename = Rails.root.join('input', 'aquity_v2', 'import.json')
    import = AquityV2Services::JsonImport.new(filename)
    import.import_property_images
  end

  # Imports districts from an Aquity V2
  # database dump in JSON format
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import districts from Aquity JSON database dump'
  task import_districts: :environment do
    filename = Rails.root.join('input', 'aquity_v2', 'import.json')
    import = AquityV2Services::JsonImport.new(filename)
    import.import_districts
  end

  # Imports districts from an Aquity V2
  # database dump in JSON format
  #
  # source file must be in input/aquity_v2/import.json
  desc 'Import import_person_property_requirements from Aquity JSON database dump'
  task import_person_property_requirements: :environment do
    filename = Rails.root.join('input', 'aquity_v2', 'import.json')
    import = AquityV2Services::JsonImport.new(filename)
    import.import_person_property_requirements
  end

end
