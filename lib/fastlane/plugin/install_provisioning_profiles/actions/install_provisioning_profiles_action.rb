require 'fileutils'
require 'shellwords'

module Fastlane
  module Actions
    class InstallProvisioningProfilesAction < Action
      def self.run(params)
        override_provisioning_profiles = params[:override_provisioning_profiles]

        UI.important("Installing provisioning profile")
        provisioning_profiles = locate_provisioning_profiles

        if provisioning_profiles.count == 0
          UI.success("No provisioning profiles found")
          return
        end

        path = target_directory
        # If the directory doesn't exist, create it first
        unless File.directory?(path)
          FileUtils.mkdir_p(path)
        end

        provisioning_profiles.each do |provisioning_profile|
          # Show the provisioning profile basename
          UI.message("Provisioning Profile: #{File.basename provisioning_profile}")

          # Retrieve the UUID of the provisioning profile
          uuid = retrieve_uuid(provisioning_profile)

          # Check if the override_provisioning_profiles is disabled
          if override_provisioning_profiles == false
            if uuid_exist(uuid)
              next
            end
          end

          # Show the UUID of the provisioning profile
          UI.message("UUID: #{uuid}")

          # Copy the provisioning profile
          copy_provisioning_profile(provisioning_profile, uuid)
        end
        UI.success("Successfully installed provisioning profiles")
      end

      def self.locate_provisioning_profiles
        Dir.glob("**/*.mobileprovision")
      end

      def self.retrieve_uuid(provisioning_profile)
        `security cms -D -i #{provisioning_profile.shellescape} | grep -A 1 '<key>UUID</key>' | tail -n 1 | grep -Eo '>.*<' | grep -Eo '[a-z0-9-]+'`.gsub("\n", "")
      end

      def self.uuid_exist(uuid)
        File.exist?("#{target_directory}/#{uuid}.mobileprovision")
      end

      def self.copy_provisioning_profile(provisioning_profile, uuid)
        target_location = "#{target_directory}/#{uuid}.mobileprovision"
        FileUtils.cp(provisioning_profile, target_location)
      end

      def self.target_directory
        File.expand_path("~/Library/MobileDevice/Provisioning Profiles")
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Install all the provisioning profiles located in you're project."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :override_provisioning_profiles,
            env_name: 'FL_INSTALL_PROVISIONING_PROFILES_OVERRIDE',
            description: 'Override existing provisioning profiles',
            is_string: false,
            optional: true,
            default_value: false
          )
        ]
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
