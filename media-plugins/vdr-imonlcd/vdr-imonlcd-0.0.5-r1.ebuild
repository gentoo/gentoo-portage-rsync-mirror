# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-imonlcd/vdr-imonlcd-0.0.5-r1.ebuild,v 1.4 2013/02/05 14:01:02 ssuominen Exp $

EAPI="3"

inherit linux-info vdr-plugin udev

DESCRIPTION="VDR Plugin: shows information about the current state of VDR on iMON LCD"
HOMEPAGE="http://projects.vdr-developer.org/wiki/plg-imonlcd"
SRC_URI="mirror://vdr-developerorg/408/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="media-libs/freetype"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

CONFIG_CHECK="~IR_IMON"

pkg_setup() {
	linux-info_pkg_setup
	vdr-plugin_pkg_setup
}

src_prepare() {
	vdr-plugin_src_prepare

	if ! use nls; then
		sed -i -e 's/\(all: libvdr-$(PLUGIN).so\) i18n/\1/' Makefile || die
	fi
}

src_install() {
	rm -f README.git
	vdr-plugin_src_install

	insinto $(get_udevdir)/rules.d
	doins "${FILESDIR}"/99-imonlcd.rules || die
}
