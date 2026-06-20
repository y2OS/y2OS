#!/bin/zsh
# y2OS ISO Build Function (Reference)
newbuild() {
    cd ~/y2-os/rootfs || { echo "Hata: rootfs dizini bulunamadı"; return 1; }
    echo "initrd.img paketleniyor (GZIP ile sıkıştırılıyor)..."
    
    # Kernel'in RAM limitlerine takılıp dosyaları kırpmaması için gzip eklendi
    sudo sh -c "find . -print0 | cpio --null -R root:root -ov --format=newc | gzip -9 > ../iso_root/boot/initrd.img"
    
    cd ~/y2-os || return 1
    [ -f "y2OS_yeni.iso" ] && rm "y2OS_yeni.iso"
    echo "ISO imajı oluşturuluyor..."
    grub-mkrescue -o y2OS_yeni.iso iso_root
}
