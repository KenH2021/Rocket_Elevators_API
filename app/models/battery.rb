class Battery < ApplicationRecord
    belongs_to :building
    has_many :columns
    belongs_to :employee
    after_initialize do
        if new_record?
          self.created_at ||= DateTime.now
        end
    end
end
