module Fastlane
  module Helper
    class InstallProvisioningProfilesHelper
      # class methods that you define here become available in your action
      # as `Helper::InstallProvisioningProfilesHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the install_provisioning_profiles plugin helper!")
      end
    end
  end
end
