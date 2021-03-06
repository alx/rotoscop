helpers = Pathname(__FILE__).dirname.expand_path / "helpers"
require helpers / "assets"
require helpers / "content"
require helpers / "form"

module Rotoscop
  module Helpers
    def self.setup
      [Assets, Content, Form].each do |helper|
        ::Merb::GlobalHelpers.send(:include, helper)
      end
    end
  end
end
