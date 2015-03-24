dep 'dots' do
  met? {
    '~/.dots'.p.exists?
  }

  meet {
    git "https://github.com/samfoo/dots.git", :to => '~/.dots'
    shell 'find ~/.dots -d 1 -name ".*" | grep -v ".git$" | grep -v ".gitignore" | xargs -I % ln -s % ~'
  }
end

