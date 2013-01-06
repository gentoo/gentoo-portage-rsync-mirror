# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/rox-media/rox-media-0.0.3.ebuild,v 1.3 2012/04/12 09:25:21 tetromino Exp $

EAPI=3
inherit rox

DESCRIPTION="Manage removable drives for ROX and other lightweight desktops"
HOMEPAGE="http://rox.sourceforge.net"
SRC_URI="mirror://gentoo/Media-0.0.3.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="x11-libs/libX11
	gnome-base/gconf:2
	|| (
		gnome-base/libgdu
		=sys-apps/gnome-disk-utility-3.0.2-r300
		<=sys-apps/gnome-disk-utility-3.0.2-r200 )
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/scons"

APPNAME="Media"
WRAPPERNAME="rox-media"
APPCATEGORY="System"

# Override rox_src_compile for this non-standard build environment
src_compile() {
	cd "${APPNAME}"
	scons

	# Cleanup build products
	rm -rf .sconf_temp .sconsign.dblite src/*.o config.log

	# Cleanup sources
	rm -rf Makefile SConstruct templates genclass geninterface \
		test.c src/*.[ch] src/Makefile src/SConscript
}
