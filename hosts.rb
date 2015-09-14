dep 'tw-robot.hostname' do
  met? {
    shell("hostname").include? "tw-robot"
  }

  meet {
    shell("sudo scutil --set HostName tw-robot")
  }
end

dep 'tw-robot' do
  requires 'homebrew'
  requires 'all-packaged-apps'
  requires 'tw-robot.hostname'
  requires 'dots'
  requires 'all-osx-settings'
  requires 'all-osx-apps'
  requires 'enable-full-disk-encryption'
end
