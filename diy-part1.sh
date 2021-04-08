#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
###################################自定义路由基础设置#####################################
#设置network（lan和wan）
sed -i "/exit 0/i\uci set network.lan.proto='static'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.lan.ipaddr='192.168.2.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.lan.gateway='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.lan.dns='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.lan.netmask='255.255.255.0'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings

sed -i "/exit 0/i\uci set network.wan.proto='static'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.wan.ipaddr='192.168.1.3'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.wan.gateway='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.wan.dns='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.wan.netmask='255.255.255.0'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings

sed -i "/exit 0/i\uci set network.wan6.proto=none" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings   #关掉wan6

sed -i "/exit 0/i\uci commit network" /workdir/openwrt/package/lean/default-settings/files/zzz-default-setting

#设置wireless
sed -i "/exit 0/i\uci set wireless.default_radio0.ssid='Airport_5G'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set wireless.default_radio0.encryption='sae-mixed'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set wireless.default_radio0.key='308fuckwj..'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings

sed -i "/exit 0/i\uci set wireless.default_radio1.ssid='Airport'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set wireless.default_radio1.encryption='sae-mixed'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set wireless.default_radio1.key='308fuckwj..'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings

sed -i "/exit 0/i\uci commit wireless" /workdir/openwrt/package/lean/default-settings/files/zzz-default-setting

#设置dhcp
sed -i "/exit 0/i\uci set uci set dhcp.@dnsmasq[0].filter_aaaa='0'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings   #关闭“禁止解析IPv6 DNS记录
”（过滤掉 IPv6(AAAA) ，只返回 IPv4 DNS 域名记录）

sed -i "/exit 0/i\uci commit dhcp" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
########################################################################################
