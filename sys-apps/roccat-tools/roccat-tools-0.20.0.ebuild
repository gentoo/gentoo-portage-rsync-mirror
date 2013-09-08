# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/roccat-tools/roccat-tools-0.20.0.ebuild,v 1.1 2013/09/08 16:25:30 hwoarang Exp $

EAPI=5

inherit readme.gentoo cmake-utils gnome2-utils udev

DESCRIPTION="Utility for advanced configuration of Roccat devices"

HOMEPAGE="http://roccat.sourceforge.net/"
SRC_URI="mirror://sourceforge/roccat/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE_INPUT_DEVICES="
	input_devices_roccat_arvo
	input_devices_roccat_isku
	input_devices_roccat_iskufx
	input_devices_roccat_kone
	input_devices_roccat_koneplus
	input_devices_roccat_konepure
	input_devices_roccat_konextd
	input_devices_roccat_kovaplus
	input_devices_roccat_lua
	input_devices_roccat_pyra
	input_devices_roccat_savu
"
IUSE="${IUSE_INPUT_DEVICES}"

REQUIRED_USE="input_devices_roccat_konextd? ( input_devices_roccat_koneplus )"

RDEPEND="
	x11-libs/gtk+:2
	x11-libs/libnotify
	media-libs/libcanberra
	virtual/libusb:1
	dev-libs/dbus-glib
	virtual/udev[gudev]
"

DEPEND="${RDEPEND}"

src_prepare() {
	# only notification daemon, move it to autostart...
	# https://sourceforge.net/p/roccat/patches/2/
	sed -i 's|share/applications|/etc/xdg/autostart|g' roccateventhandler/CMakeLists.txt || \
	die "sed failed"
}

src_configure() {
	local UDEVDIR="$(udev_get_udevdir)"/rules.d
	local MODELS=${INPUT_DEVICES//roccat_/}
	mycmakeargs=( -DDEVICES=${MODELS// /;} \
	-DUDEVDIR="${UDEVDIR/"//"//}" )
	cmake-utils_src_configure
}
src_install() {
	cmake-utils_src_install
	readme.gentoo_src_install
}
pkg_preinst() {
	gnome2_icon_savelist
}
pkg_postinst() {
	enewgroup roccat
	gnome2_icon_cache_update
	readme.gentoo_print_elog
}

pkg_postrm() {
	gnome2_icon_cache_update
}
