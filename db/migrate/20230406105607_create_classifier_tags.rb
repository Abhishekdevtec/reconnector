class CreateClassifierTags < ActiveRecord::Migration[7.0]
  def change
    create_table :classifier_tags do |t|
      t.references :taggable, polymorphic: true, null: false
      t.references :classifier, null: false, foreign_key: true

      t.timestamps
    end

    Contact.find_each do |contact|
      contact.classifications.each do |classification|
        classifier = contact.account.classifiers.find_by!(name: classification.name)
        ClassifierTag.create!(taggable: contact, classifier: classifier)
      end
    end
  end
end
