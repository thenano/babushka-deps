dep 'Dropbox.app' do
  source "https://www.dropbox.com/download?plat=mac"
end

dep 'Alfred.app' do
  source "http://cachefly.alfredapp.com/Alfred_2.1.1_227.zip"
end

dep 'iTerm.app' do
  source "http://iterm2.com/downloads/stable/iTerm2_v1_0_0.zip"
end

dep 'Spectacle.app' do
  source "https://s3.amazonaws.com/spectacle/downloads/Spectacle+0.8.4.zip"
end

dep 'Chromium.app' do
  source "https://commondatastorage.googleapis.com/chromium-browser-snapshots/Mac/236234/chrome-mac.zip"
end

dep 'Transmission.app' do
  source 'http://download.transmissionbt.com/files/Transmission-2.82.dmg'
end

dep 'all-osx-apps' do
  requires 'iTerm.app'
  requires 'Alfred.app'
  requires 'Dropbox.app'
  requires 'Chromium.app'
  requires 'Transmission.app'
end

dep 'set-dock-magnification' do
  met? {
    shell?("defaults read com.apple.dock magnification") &&
      shell("defaults read com.apple.dock magnification").to_i == 1
  }

  meet {
    shell("defaults write com.apple.dock magnification -integer 1")
  }
end

dep 'move-dock-right' do
  met? {
    shell?("defaults read com.apple.dock orientation") &&
      shell("defaults read com.apple.dock orientation") == "right"
  }

  meet {
    shell("defaults write com.apple.dock orientation -string 'right'")
  }
end

dep 'disable-widgets' do
  met? {
    cmd = "defaults read com.apple.dashboard mcx-disabled"
    shell?(cmd) &&
      shell(cmd).to_i == 1
  }

  meet {
    shell 'defaults write com.apple.dashboard mcx-disabled -boolean YES'
  }
end

dep 'fast-key-repeat' do
  met? {
    2 == shell('defaults read NSGlobalDomain KeyRepeat').to_i &&
      12 == shell('defaults read NSGlobalDomain InitialKeyRepeat').to_i
  }

  meet {
    shell('defaults write NSGlobalDomain KeyRepeat -int 2')
    shell('defaults write NSGlobalDomain InitialKeyRepeat -int 12')
  }
end

dep 'capslock-to-ctrl' do
  met? {
    cmd = "defaults -currentHost read -g com.apple.keyboard.modifiermapping.1452-610-0"
    shell?(cmd) && shell(cmd) ==
%Q{(
        {
        HIDKeyboardModifierMappingDst = 2;
        HIDKeyboardModifierMappingSrc = 0;
    }
)}
  }

  meet {
    shell("defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-610-0 -array-add '<dict><key>HIDKeyboardModifierMappingDst</key><integer>2</integer><key>HIDKeyboardModifierMappingSrc</key><integer>0</integer></dict>'")
  }
end

dep 'enable-assistive-devices' do
  met? {
    "/private/var/db/.AccessibilityAPIEnabled".p.exists?
  }

  meet {
    shell "sudo touch /private/var/db/.AccessibilityAPIEnabled"
  }
end

dep 'all-osx-settings' do
  requires 'capslock-to-ctrl'
  requires 'fast-key-repeat'
  requires 'disable-widgets'
  requires 'move-dock-right'
  requires 'enable-assistive-devices'
end
