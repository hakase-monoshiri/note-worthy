class Note < ActiveRecord::Base
    belongs_to :user

    def composite_index
      index = self.difficulty * self.satisfaction_rating
     index
    end
  end