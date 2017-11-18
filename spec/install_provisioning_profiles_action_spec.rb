describe Fastlane::Actions::InstallProvisioningProfilesAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The install_provisioning_profiles plugin is working!")

      Fastlane::Actions::InstallProvisioningProfilesAction.run(nil)
    end
  end
end
