# Linux DevOps Fundamentals Lab using Vagrant

## 📘 Project Title

**Linux DevOps Fundamentals Lab using Vagrant**

## 🎯 Objective
Create a real-world Linux environment for DevOps engineers using **Vagrant and VirtualBox**, simulating a cloud-like EC2 instance. The lab will walk you through Linux user/group management, permissions, file operations, volume management, and system cleanup — all offline on your local machine.

---

## 📦 Requirements

### Host Machine

- OS: Windows, macOS, or Linux
- RAM: Minimum 2GB (recommended: 4GB)
- Virtualization support enabled in BIOS

### Software

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://developer.hashicorp.com/vagrant/downloads)
- (Optional) Git for managing scripts

---

## 🚀 Project Setup

### 1. Create Project Directory

```bash
mkdir linux-devops-lab
cd linux-devops-lab
```

### 2. Initialize Vagrant

```bash
vagrant init ubuntu/focal64
```

### 3. Update Vagrantfile

Replace contents of `Vagrantfile` with:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.network "private_network", type: "dhcp"

  config.vm.provision "shell", inline: <<-SHELL
    apt update -y
    apt install -y vim tree lvm2
  SHELL
end
```

### 4. Start the Virtual Machine

```bash
vagrant up
vagrant ssh
```

Now you're inside a local Linux VM.

---

## 💽 Simulating EBS Volume

### Step 1: Create Virtual Disk

On host machine:

```bash
VBoxManage createhd --filename ~/VirtualBoxVMs/devops-ebs.vdi --size 5120
```

### Step 2: Attach to VM

1. Power off VM: `vagrant halt`
2. Open **VirtualBox GUI**
3. Select VM > Settings > Storage
4. Add new hard disk under SATA controller → Select created `.vdi`
5. Start VM again: `vagrant up`

### Step 3: Format & Mount

Inside VM:

```bash
lsblk
sudo mkfs.ext4 /dev/sdb
sudo mkdir /data
sudo mount /dev/sdb /data
df -h | grep data
```

---

## 🧪 Linux Tasks (Adapted from Project)

### 1. As root (default user in Vagrant with sudo)

```bash
sudo adduser user1
sudo adduser user2
sudo adduser user3
sudo groupadd devops
sudo groupadd aws
sudo usermod -g devops user2
sudo usermod -g devops user3
sudo usermod -aG aws user1
```

Create directories and files:

```bash
sudo mkdir -p /dir1 /dir2/dir1/dir2/dir10 /dir6/dir4 /dir7/dir10 /opt/dir14/dir10
sudo touch /f2 /dir1/f1
sudo chgrp devops /dir1 /dir7/dir10 /f2
sudo chown user1 /dir1 /dir7/dir10 /f2
```

### 2. Switch to user1

```bash
sudo su - user1
sudo adduser user4
sudo adduser user5
sudo groupadd app
groupadd database
```

### 3. As user4

```bash
sudo su - user4
mkdir -p /dir6/dir4
sudo touch /f3
sudo mv /dir1/f1 /dir2/dir1/dir2/
sudo mv /f2 /f4
```

### 4. Back as user1

```bash
sudo su - user1
mkdir /home/user2/dir1
cd /dir2/dir1/dir2/dir10
sudo touch ../../../../opt/dir14/dir10/f1
sudo mv /opt/dir14/dir10/f1 ~/
sudo rm -r /dir4
sudo rm -rf /opt/dir14/*
echo "Linux assessment for an DevOps Engineer!! Learn with Fun!!" > /f3
```

### 5. As user2

```bash
sudo su - user2
touch /dir1/f2
rm -rf /dir6 /dir8
sed -i 's/DevOps/devops/g' /f3
for i in {1..10}; do sed -n '1p' /f3 >> /f3; done
sed -i 's/Engineer/engineer/g' /f3
rm /f3
```

### 6. As root again

```bash
sudo find / -name f3
sudo find / -type f | wc -l
tail -n 1 /etc/passwd
```

### 7. Volume Ops (already mounted /data)

```bash
sudo touch /data/f1
```

### 8. As user5

```bash
sudo su - user5
rm -rf /dir1 /dir2 /dir3 /dir5 /dir7 /f1 /f4 /opt/dir14
```

### 9. Final cleanup as root

```bash
sudo deluser --remove-home user1
sudo deluser --remove-home user2
sudo deluser --remove-home user3
sudo deluser --remove-home user4
sudo deluser --remove-home user5
sudo groupdel app
sudo groupdel aws
sudo groupdel database
sudo groupdel devops
sudo umount /data
sudo rm -rf /data
```

### 10. Detach Virtual Disk (Manual)

- Shut down VM: `vagrant halt`
- Remove attached `.vdi` from VirtualBox GUI

---

## 📁 Project Output

You now have:

- Local environment simulating EC2 + EBS
- Practice in system admin tasks with real Linux
- Verified file operations, mounts, user/group configs
- Lab fully reproducible with `vagrant up`

---

## 📄 Resume/Portfolio Description

> Designed and implemented a local Linux DevOps lab using Vagrant and VirtualBox to simulate EC2 and EBS environments. Practiced user and group administration, permissions, file system operations, and volume management — replicating day-to-day tasks of a cloud DevOps engineer without using AWS.

---

## 📚 Author

Vagrant-based local version by: *[Rimandeep Singh]*