alias g='git'
alias sl='ls'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias duf='du -sk | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias jcurl='curl -v -H "Accept: application/json" -H "Content-type: application/json" -b .cookies -c .cookies'
alias susp='dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Suspend'
alias hib='dbus-send --print-reply --system --dest=org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower.Hibernate'
alias neo='setxkbmap de neo -option'
alias de='setxkbmap de'
alias us='setxkbmap us'
alias tubvpn='sudo openconnect vpn.tu-berlin.de --script  /etc/vpnc/vpnc-script'
alias banot='ssh alu7053@banot.etsii.ull.es'
alias clip='xsel -b'
alias j='jobs'
alias h='history'
alias nonose='nosetests --nocapture --nologcapture'
alias wifioff='nmcli nm wifi off'
alias wifion='nmcli nm wifi on'
alias anaconda='source ~/Apps/anaconda/bin/activate normal'
alias deactivate='source ~/Apps/anaconda/bin/deactivate'
alias disablenmnotifications='gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"; gsettings set org.gnome.nm-applet disable-connected-notifications "true"'
alias enablenmnotifications='gsettings set org.gnome.nm-applet disable-disconnected-notifications "true"; gsettings set org.gnome.nm-applet disable-connected-notifications "true"'
alias scan='nmap -sP 192.168.178.255/24'
alias invert='xcalib -invert -alter'
alias ap='aptitude'
