dep 'MacArtha.hostname' do
  met? {
    shell("hostname").include? "MacArtha"
  }

  meet {
    shell("sudo scutil --set HostName MacArtha")
  }
end

dep 'MacArtha' do
  requires 'homebrew'
  requires 'all-packaged-apps'
  requires 'MacArtha.hostname'
  requires 'dots'
  requires 'all-osx-settings'
  requires 'all-osx-apps'
  requires 'all-fonts'
  requires 'enable-full-disk-encryption'
end

dep 'MacFly.hostname' do
  met? {
    shell("hostname").include? "MacFly"
  }

  meet {
    shell("sudo scutil --set HostName MacFly")
  }
end

dep 'MacFly' do
  requires 'homebrew'
  requires 'all-packaged-apps'
  requires 'MacFly.hostname'
  requires 'dots'
  requires 'all-osx-settings'
  requires 'all-osx-apps'
  requires 'all-fonts'
  requires 'enable-full-disk-encryption'
end
