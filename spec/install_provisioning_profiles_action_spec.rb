describe Fastlane::Actions::InstallProvisioningProfilesAction do
  describe '#run' do
    it 'prints a message' do
      Fastlane::Actions::InstallProvisioningProfilesAction.run(override_provisioning_profiles: false)
      Fastlane::Actions::InstallProvisioningProfilesAction.run(override_provisioning_profiles: true)
    end
  end
end
