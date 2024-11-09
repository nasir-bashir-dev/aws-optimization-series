
# 📘 AWS❎EC2❎EBS Storage Optimization Commands

This guide provides step-by-step instructions to prepare a new volume, migrate data, and ensure the new volume is bootable. Incase, a beginner, please proceed with caution and ensure you have backups before performing these operations.

---

## 📂 1. Verify the Volume's File System

Check the type of the file system of the volume.

```shell
sudo file -s /dev/xvdf
```

**Description:** This command reports the type of file system present on `/dev/xvdf`. If it's empty or unformatted, you'll receive an appropriate message.

---

## 📝 2. Format the New Volume to `ext4`

Format the volume with the `ext4` file system.

```shell
sudo mkfs -t ext4 /dev/xvdf
```

**Alternative Command:**

```shell
sudo mke4fs -t ext4 /dev/xvdf
```

**Description:** Initializes a new `ext4` file system on `/dev/xvdf`, erasing any existing data.

---

## 📁 3. Create a Mount Point

Create a directory to mount the new volume.

```shell
sudo mkdir /mnt/new-vol
```

**Description:** Makes a new directory at `/mnt/new-vol` to serve as the mount point for the new volume.

---

## 📌 4. Mount the New Volume

Mount the volume to the newly created directory.

```shell
sudo mount /dev/xvdf /mnt/new-vol
```

**Description:** Attaches the `/dev/xvdf` volume to the file system at `/mnt/new-vol`.

---

## 🔄 5. Synchronize Data to the New Volume

Copy all data from the root directory to the new volume.

```shell
sudo rsync -axv / /mnt/new-vol/
```

**Description:** Uses `rsync` to copy files from `/` to `/mnt/new-vol/`, preserving permissions, links, and timestamps.

---

## ⚙️ 6. Install GRUB Bootloader on the New Volume

Ensure the new volume is bootable by installing GRUB.

```shell
sudo grub-install --root-directory=/mnt/new-vol/ --force /dev/xvdf
```

**Description:** Installs the GRUB bootloader to `/dev/xvdf` using the files located in `/mnt/new-vol/`.

---

## 🚫 7. Unmount the New Volume

Safely unmount the volume after data synchronization.

```shell
sudo umount /mnt/new-vol
```

**Description:** Detaches the `/dev/xvdf` volume from the file system.

---

## 🔍 8. Identify the Original Volume's UUID and Label

List all block devices with their UUIDs and labels.

```shell
blkid
```

**Sample Output:**

```
/dev/xvda1: LABEL="cloudimg-rootfs" UUID="263dc91a-fc69-2314-cdaf-23cabc336a24" TYPE="ext4" PTTYPE="dos"
```

**Description:** Displays information about available block devices, including their UUIDs and labels.

---

## 🆔 9. Update the New Volume's UUID

Set the new volume's UUID to match the original volume's UUID.

```shell
sudo tune2fs -U 263dc91a-fc69-2314-cdaf-23cabc336a24 /dev/xvdf
```

**Description:** Changes the UUID of `/dev/xvdf` to `263dc91a-fc69-2314-cdaf-23cabc336a24`. Replace the UUID with the one from your original volume.

---

## 🔖 10. Check the Original Volume's Label

Retrieve the label of the original volume.

```shell
sudo e2label /dev/xvda1
```

**Expected Output:**

```
cloudimg-rootfs
```

**Description:** Displays the file system label of `/dev/xvda1`.

---

## 🏷️ 11. Set the New Volume's Label

Assign the original volume's label to the new volume.

```shell
sudo e2label /dev/xvdf cloudimg-rootfs
```

**Description:** Sets the label of `/dev/xvdf` to `cloudimg-rootfs`, matching it with the original volume.

---
