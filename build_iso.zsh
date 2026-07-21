#!/bin/zsh

WORKSPACE="$PWD"
BUILD_DIR="initramfs_build"
ROOTFS_DIR="rootfs"
KERNEL_VER="7.0.3"
OUTPUT_IMG="initramfs.img"
ISO_NAME="y2OS_yeni.iso"

cd "$WORKSPACE" || exit 1

echo "==> [1/4] Creating Initramfs..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"/{bin,dev,etc,lib,mnt,proc,sys,newroot}
mkdir -p "$BUILD_DIR/lib/modules/$KERNEL_VER"
mkdir -p "$BUILD_DIR/lib/firmware"

cp "$ROOTFS_DIR/bin/busybox" "$BUILD_DIR/bin/"
ln -s busybox "$BUILD_DIR/bin/sh"
ln -s busybox "$BUILD_DIR/bin/mount"
ln -s busybox "$BUILD_DIR/bin/mdev"
ln -s busybox "$BUILD_DIR/bin/switch_root"

echo "    -> Copying modules and firmware..."
cp -a "$ROOTFS_DIR/lib/modules/$KERNEL_VER/"* "$BUILD_DIR/lib/modules/$KERNEL_VER/"
cp -a "$ROOTFS_DIR/lib/firmware/"* "$BUILD_DIR/lib/firmware/"

cat << 'EOF' > "$BUILD_DIR/init"
#!/bin/sh
mount -t devtmpfs devtmpfs /dev
mount -t proc proc /proc
mount -t sysfs sysfs /sys

echo "y2OS RAM-Disk Started. Scanning hardware..."
echo /bin/mdev > /proc/sys/kernel/hotplug
mdev -s

for arg in $(cat /proc/cmdline); do
    case $arg in
        root=*) ROOT_DEV=${arg#root=} ;;
    esac
done

sleep 3 

if [ -z "$ROOT_DEV" ]; then
    echo "ERROR: root= parameter missing!"
    /bin/sh
fi

echo "Mounting target: $ROOT_DEV"
mount -o ro "$ROOT_DEV" /newroot

if [ $? -ne 0 ]; then
    echo "ERROR: Failed to mount $ROOT_DEV. Dropping to shell..."
    /bin/sh
fi

mount --move /sys /newroot/sys
mount --move /proc /newroot/proc
mount --move /dev /newroot/dev

exec switch_root /newroot /sbin/init
EOF

chmod +x "$BUILD_DIR/init"

echo "    -> Packing image..."
cd "$BUILD_DIR" || exit 1
find . -print0 | cpio --null -ov --format=newc 2>/dev/null | gzip -9 > "../$OUTPUT_IMG"
cd ..

echo "==> [2/4] Placing Initramfs into Rootfs/boot..."
mkdir -p "$ROOTFS_DIR/boot"
cp "$OUTPUT_IMG" "$ROOTFS_DIR/boot/$OUTPUT_IMG"

echo "==> [3/4] Creating Live ISO RAM disk..."
mkdir -p iso_root/boot
cd "$ROOTFS_DIR" || exit 1
sudo sh -c "find . -print0 | cpio --null -R root:root -ov --format=newc | gzip -9 > ../iso_root/boot/initrd.img"
cd ..

echo "==> [4/4] Building bootable ISO..."
[ -f "$ISO_NAME" ] && rm "$ISO_NAME"
grub-mkrescue -o "$ISO_NAME" iso_root

echo "==> SUCCESS! $ISO_NAME is ready."
