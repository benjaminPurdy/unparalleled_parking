class Branch < ActiveRecord::Base
    validates :uid, presence: true
end
