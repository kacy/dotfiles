function vpn-connect() {
    sudo openvpn /etc/openvpn/$1/config.conf
}
