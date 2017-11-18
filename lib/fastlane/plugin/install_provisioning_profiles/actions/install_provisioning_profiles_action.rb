module Fastlane
  module Actions
    class InstallProvisioningProfilesAction < Action
      def self.run(params)
        UI.important("🚀  Installing provisioning profile")
        provisioning_profiles = locate_provisioning_profiles

        if provisioning_profiles.count == 0
          UI.success("🚀  No provisioning profiles found")
          return
        end

        provisioning_profiles.each do | provisioning_profile |
          # Show the provisioning profile basename
          UI.message("🚀  Provisioning Profile: #{File.basename provisioning_profile}")

          # Retrieve the UUID of the provisioning profile
          uuid = retrieve_uuid(provisioning_profile)

          # Show the UUID of the provisioning profile
          UI.message("🚀  UUID: #{uuid}")

          # Copy the provisioning profile
          copy_provisioning_profile(provisioning_profile, uuid)
        end
        UI.success("🚀  Successfully installed provisioning profiles")
      end

      def self.locate_provisioning_profiles
        Dir.glob("**/*.mobileprovision")
      end
      

      def self.retrieve_uuid(provisioning_profile)
        `/usr/libexec/PlistBuddy -c 'Print :UUID' /dev/stdin <<< $(security cms -D -i #{provisioning_profile})`.gsub("\n","")
      end

      def self.copy_provisioning_profile(provisioning_profile, uuid)
        target_directory = "~/Library/MobileDevice/Provisioning\\ Profiles/#{uuid}.mobileprovision"
        `cp -R #{provisioning_profile} #{target_directory}`
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Install all the provisioning profiles located in you're project."
      end

      def self.authors
        ["dgyesbreghs"]
      end

      def self.is_supported?(platform)
        platform == :ios
      end
    end
  end
end
