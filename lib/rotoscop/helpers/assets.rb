module Rotoscop
  module Helpers
    module Assets
      def rotoscop_image_path(*segments)
        rotoscop_public_path_for(:image, *segments)
      end

      def rotoscop_javascript_path(*segments)
        rotoscop_public_path_for(:javascript, *segments)
      end

      def rotoscop_stylesheet_path(*segments)
        rotoscop_public_path_for(:stylesheet, *segments)
      end
      
      def rotoscop_upload_path(*segments)
        rotoscop_public_path_for(:upload, *segments)
      end

      def rotoscop_public_path_for(type, *segments)
        ::Rotoscop.public_path_for(type, *segments)
      end
    end
  end
end