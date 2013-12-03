dep 'hostname' do
  met? {
    shell("hostname").include? "cape-town"
  }

  meet {
    shell("sudo scutil --set HostName cape-town")
  }
end

dep 'cape-town' do
  requires 'homebrew'
  requires 'all-packaged-apps'
  requires 'hostname'
  requires 'dots'
  requires 'all-osx-settings'
  requires 'all-osx-apps'
  requires 'enable-full-disk-encryption'
end

