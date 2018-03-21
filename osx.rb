dep 'VLC.app' do
  source "http://get.videolan.org/vlc/2.2.1/macosx/vlc-2.2.1.dmg"
end

dep 'VirtualBox.installer' do
  source "http://download.virtualbox.org/virtualbox/5.0.4/VirtualBox-5.0.4-102546-OSX.dmg"
end

dep 'Google Chrome.app' do
  source "http://dl.google.com/chrome/mac/dev/GoogleChrome.dmg"
end

dep 'Firefox.app' do
  source "https://www.mozilla.org/en-US/firefox/new/?scene=2"
end

dep 'Atom.app' do
  source 'https://atom.io/download/mac'
end

dep 'Backup and Sync.app' do
  source 'http://dl.google.com/drive/installbackupandsync.dmg'
end

dep 'Docker.app' do
  source 'https://download.docker.com/mac/stable/Docker.dmg'
end

dep 'IntelliJ IDEA.app' do
  source 'https://download.jetbrains.com/idea/ideaIU-2017.3.5.dmg'
end

dep 'all-osx-apps' do
  requires 'VLC.app'
  requires 'VirtualBox.installer'
  requires 'Google Chrome.app'
  requires 'Firefox.app'
  requires 'Atom.app'
  requires 'Backup and Sync.app'
  requires 'Docker.app'
  requires 'IntelliJ IDEA.app'
end

dep 'enable-full-disk-encryption' do
  met? {
    shell?("sudo fdesetup status").include? "On"
  }

  meet {
    shell("sudo fdesetup enable -user `whoami`")
  }
end

meta 'default' do
  accepts_value_for :domain
  accepts_value_for :default
  accepts_value_for :value
  accepts_value_for :type

  template {
    met? {
      shell?("defaults read \"#{domain}\" #{default}") &&
        shell("defaults read \"#{domain}\" #{default}") == value
    }

    meet {
      shell("defaults write \"#{domain}\" #{default} -#{type} #{value}")
    }
  }
end


dep 'set-dock-magnification.default' do
  domain 'com.apple.dock'
  default 'magnification'
  value '1'
  type 'integer'
end

dep 'auto-hide-dock.default' do
  domain 'com.apple.dock'
  default 'magnification'
  value '1'
  type 'integer'
end

dep 'disable-widgets.default' do
  domain 'com.apple.dashboard'
  default 'mcx-disabled'
  value '1'
  type 'integer'
end

dep 'fast-key-repeat.default' do
  domain 'NSGlobalDomain'
  default 'KeyRepeat'
  value '2'
  type 'integer'
end

dep 'fast-key-initial-repeat.default' do
  domain 'NSGlobalDomain'
  default 'InitialKeyRepeat'
  value '12'
  type 'integer'
end

dep 'set-correct-fn-keys.default' do
  domain 'Apple Global Domain'
  default 'com.apple.keyboard.fnState'
  value '1'
  type 'integer'
end

dep 'set-ask-for-password-on-sleep.default' do
  domain 'com.apple.screensaver'
  default 'askForPassword'
  value '1'
  type 'integer'
end

dep 'set-ask-for-password-on-sleep-delay.default' do
  domain 'com.apple.screensaver'
  default 'askForPasswordDelay'
  value '0'
  type 'integer'
end

dep 'set-dark-theme.default' do
  domain 'Apple Global Domain'
  default 'AppleInterfaceStule'
  value 'Dark'
  type 'string'
end

dep 'all-osx-settings' do
  requires 'set-dock-magnification.default'
  requires 'auto-hide-dock.default'
  requires 'disable-widgets.default'
  requires 'fast-key-repeat.default'
  requires 'fast-key-initial-repeat.default'
  requires 'set-correct-fn-keys.default'
  requires 'set-ask-for-password-on-sleep.default'
  requires 'set-ask-for-password-on-sleep-delay.default'
  requires 'set-dark-theme.default'
end
