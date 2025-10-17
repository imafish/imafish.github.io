# Encryption

## gocryptfs

``` shell
sudo apt install gocryptfs

# Init
mkdir ~/encrypted_data ~/mountpoint
gocryptfs -init ~/encrypted_data

# Mount
gocryptfs ~/encrypted_data ~/mountpoint

# Unmount
fusermount -u ~/mountpoint
```
