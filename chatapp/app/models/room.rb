class Room < ApplicationRecord
    enum status: { draft: 0, published: 1 }

    def abbreviated_title
        name.size >= 20 ? "#{name.slice(0, 19)}..." : name
    end

    def publish
        return if self.published?
        # https://railsguides.jp/active_record_basics.html#update
        update({status: Room.statuses['published'], published_at: Time.current})
    end
end
