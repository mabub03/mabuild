dnf -y config-manager addrepo --from-repofile=https://raw.githubusercontent.com/terrapkg/subatomic-repos/main/terra.repo

sudo dnf in -y v4l2loopback

VER=$(ls /lib/modules) &&
  akmods --force --kernels $VER --kmod v4l2loopback &&
  depmod -a $VER &&
  dracut --kver $VER --force --add ostree --no-hostonly --reproducible /usr/lib/modules/$VER/initramfs.img

rm -f /etc/yum.repos.d/{*terra*}.repo
