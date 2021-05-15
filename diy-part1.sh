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
#####################################自定义编译源########################################
echo "src-git video https://github.com/openwrt/video.git" >> /workdir/openwrt/feeds.conf.default
echo "src-git targets https://github.com/openwrt/targets.git" >> /workdir/openwrt/feeds.conf.default
echo "src-git management https://github.com/openwrt-management/packages.git" >> /workdir/openwrt/feeds.conf.default
echo "src-git oldpackages http://git.openwrt.org/packages.git" >> /workdir/openwrt/feeds.conf.default
echo "src-link custom /usr/src/openwrt/custom-feed" >> /workdir/openwrt/feeds.conf.default
echo "src-git helloworld https://github.com/fw876/helloworld" >> /workdir/openwrt/feeds.conf.default
echo "src-git openclash https://github.com/vernesong/OpenClash.git" >> feeds.conf.default
echo "src-git kenzo https://github.com/V2RaySSR/openwrt-packages" >> feeds.conf.default
echo "src-git small https://github.com/V2RaySSR/small" >> feeds.conf.default
########################################################################################

###################################自定义路由基础设置#####################################
#设置network（lan和wan）
#sed -i "/exit 0/i\uci set network.lan.proto='static'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.lan.ipaddr='192.168.2.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
#sed -i "/exit 0/i\uci set network.lan.gateway='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
#sed -i "/exit 0/i\uci set network.lan.dns='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set network.lan.netmask='255.255.255.0'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
##以下针对wan设置二选一，第一种是光猫拨号，wan设置为光猫内网的静态ip；第二种是光猫桥接，wan设置为PPPoE拨号，同时给wan口再增设一个光猫内网的静态ip，这样可做到路由器局域网访问到光猫的后台。
sed -i "/exit 0/i\uci set network.wan.proto='static'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings             #第一种
sed -i "/exit 0/i\uci set network.wan.ipaddr='192.168.1.3'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings       #第一种
sed -i "/exit 0/i\uci set network.wan.gateway='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings      #第一种
sed -i "/exit 0/i\uci set network.wan.dns='192.168.1.1'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings          #第一种
sed -i "/exit 0/i\uci set network.wan.netmask='255.255.255.0'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings    #第一种
sed -i "/exit 0/i\uci set network.wan6.proto=none" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings   #关掉wan6     #第一种

#第二种有时间再研究

sed -i "/exit 0/i\uci commit network" /workdir/openwrt/package/lean/default-settings/files/zzz-default-setting

#设置wireless
sed -i "/exit 0/i\uci set wireless.default_radio0.ssid='Airport_5G'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set wireless.default_radio0.encryption='psk-mixed'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings #sae-mixed:wap2/3混合模式；psk-mixed：wap/wap2混合模式；
sed -i "/exit 0/i\uci set wireless.default_radio0.key='308fuckwj..'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings

sed -i "/exit 0/i\uci set wireless.default_radio1.ssid='Airport'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i\uci set wireless.default_radio1.encryption='psk-mixed'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings #sae-mixed:wap2/3混合模式；psk-mixed：wap/wap2混合模式；
sed -i "/exit 0/i\uci set wireless.default_radio1.key='308fuckwj..'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings

sed -i "/exit 0/i\uci commit wireless" /workdir/openwrt/package/lean/default-settings/files/zzz-default-setting

#设置dhcp
sed -i "/exit 0/i\uci set dhcp.@dnsmasq[0].filter_aaaa='0'" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings   #关闭“禁止解析IPv6 DNS记录”（过滤掉 IPv6(AAAA) ，只返回 IPv4 DNS 域名记录）

sed -i "/exit 0/i\uci commit dhcp" /workdir/openwrt/package/lean/default-settings/files/zzz-default-settings
########################################################################################
