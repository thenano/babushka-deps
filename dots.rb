dep 'dots' do
  met? {
    '~/.dots'.p.exists?
  }

  meet {
    git "https://github.com/thenano/dots.git", :to => '~/.dots'
    shell 'ln -s ~/.dots/bash/bash_profile ~/.bash_profile'
    shell 'ln -s ~/.dots/git/gitconfig ~/.gitconfig'
    shell 'ln -s ~/.dots/git/gitignore ~/.gitignore'
  }
end

