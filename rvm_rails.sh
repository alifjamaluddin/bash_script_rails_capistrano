echo "===> Installing RVM >>"
bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )

#Reload shell
. ~/.rvm/scripts/rvm

result=`type rvm | head -1`
echo "===> Result of testing RVM : '$result'"
if [ "$result" == "rvm is a function" ]; then
  echo '===> RVM system install successful.'
else
  echo '===> Error - Installation not successful, RVM should be a function not a binary - See http://rvm.beginrescueend.com/rvm/install/ for more info'
  return
fi

if ! grep -q 'rvm_archflags="-arch x86_64"' "$HOME/.rvmrc" ; then
  echo "===> Adding arch_flags for 64 bit on .RVMRC"
  echo  'rvm_archflags="-arch x86_64"' >> "$HOME/.rvmrc"
fi

. "$HOME/.rvmrc"
. ~/.rvm/scripts/rvm

#Change ruby version to your prefered version
echo '===> Installing Ruby 2.2.1'
rvm install 2.2.1

echo '===> Setting default to 2.2.1'
rvm --default use 2.2.1


current_user=`whoami`
echo "===> Fixing permissions and ensuring $current_user has access"
chown -R $current_user ~/.rvm

profile_location=`bash_profile_location`

source ~/.rvm/scripts/rvm

echo "===> Set Rubygem"
rvm rubygems current

echo "===> Install Rails and Bundler"
gem install rails --no-ri --no-rdoc -V
gem install bundler --no-ri --no-rdoc -V
