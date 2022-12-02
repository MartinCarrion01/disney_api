module Attachable
    extend ActiveSupport::Concern

    included do
        has_one_attached :image

        def get_image_url
            image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(image, host: "http://127.0.0.1:3000") : ''
        end
    end
end