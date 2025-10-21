# VNC

To setup VNC:

1. Install VNC viewer of any kind (realvnc viewer for instance) on the client machine.
2. Install VNC server on the host
3. Install a virtual desktop
4. Configure VNC server
5. Start VNC server
6. Connect

## tight VNC server + xfce4

### install tight vnc server

``` bash
sudo apt install tightvncserver
```

### install virtual desktop (xfce4)

``` bash
sudo apt install xfce4 xfce4-goodies
```

### setup VNC connection password

``` bash
tightvncpasswd
```

### setup VNC

#### uncomment entries base on the requirement

``` bash
sudo vi /etc/tightvncserver.conf
```

#### setup tight VNC to use xfce4

edit `$HOME/.vnc/xstartup` and add the following last three lines

``` bash
#!/bin/sh

xrdb "$HOME/.Xresources"
xsetroot -solid grey
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
#x-window-manager &
# Fix to make GNOME work
export XKL_XMODMAP_DISABLE=1
/etc/X11/Xsession

#
# ADD THESE LINES TO xstartup
#
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
startxfce4 &
```

### start VNC server

``` bash
vncserver

# the service is hosted on port 5090+<X window index>
```

### kill VNC server

``` bash
vncserver -kill :2
```
