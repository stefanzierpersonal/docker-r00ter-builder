#!/bin/sh 

# automatic build maker 16meg routers

#build version

configfix() {
	DNS=$(cat "./.config" | grep "CONFIG_PACKAGE_dnsmasq-full=y")
	if [ ! -z $DNS ]; then
		sed -i -e 's/CONFIG_PACKAGE_dnsmasq=y/# CONFIG_PACKAGE_dnsmasq is not set/g' ./.config
	fi
	WPAD=$(cat "./.config" | grep "CONFIG_PACKAGE_wpad-basic=y")
	if [ ! -z $WPAD ]; then
		sed -i -e 's/CONFIG_PACKAGE_wpad-basic=y/# CONFIG_PACKAGE_wpad-basic is not set/g' ./.config
	fi
	WPAD=$(cat "./.config" | grep "CONFIG_PACKAGE_wpad=y")
	if [ ! -z $WPAD ]; then
		sed -i -e 's/CONFIG_PACKAGE_wpad-mini=y/# CONFIG_PACKAGE_wpad-mini is not set/g' ./.config
	fi
}

DATE="2021-01-31"

rm -rf ./bin
NAME="GoldenOrb_"
CODE=$NAME$DATE
rm -rf ./files
mkdir -p ./files/etc

echo 'CODENAME="'"$CODE"'"' > ./files/etc/codename

echo "                            <model>" > ./files/etc/header_msg
echo "/img/header.png" >> ./files/etc/header_msg
echo "/img/rosy.jpg" >> ./files/etc/header_msg

BASE="openwrt-"
BASEO="openwrt-ar71xx-generic-tl-"
BASEQ="openwrt-ar71xx-generic-"
ENDO="-squashfs-factory"
ENDU="-squashfs-sysupgrade"

TYP="-GO"
END=$TYP$DATE

# WG3526

cp ./configfiles/16meg/.config_3526 ./.config
configfix
make -j5 V=s

MOD="wg3526"
EXTB=".bin"

ORIG=openwrt-ramips-mt7621-zbt-wg3526-16M-squashfs-sysupgrade.bin
FIRM=$BASE$MOD$END-upgrade$EXTB
cp ./bin/targets/ramips/mt7621/$ORIG ./images/$FIRM
cd ./images
zip $MOD$END.zip $FIRM
rm -f $FIRM
cd ..

# WG1608

echo "ZBT WG1608" > ./files/etc/custom
echo "ZBT WG1608" >> ./files/etc/custom
echo "ROOter" >> ./files/etc/custom
cp ./configfiles/16meg/.config_3526 ./.config
configfix
make -j5

MOD="WG1608"
EXTB=".bin"

ORIG=openwrt-ramips-mt7621-zbt-wg3526-16M-squashfs-sysupgrade.bin
FIRM=$BASE$MOD$END-upgrade$EXTB
cp ./bin/targets/ramips/mt7621/$ORIG ./images/$FIRM
cd ./images
zip $MOD$END.zip $FIRM
rm -f $FIRM
cd ..cp ./configfiles/16meg/.config_x750 ./.config
configfix
make V=s
