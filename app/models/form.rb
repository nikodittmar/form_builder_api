class Form < ApplicationRecord
    belongs_to :user

    validate :components_are_valid

    def components_are_valid
        unless JSON::Validator.validate('app/models/schemas/components.json', components)
            errors.add(:components, "must conform to structure")
        end
    end
end
