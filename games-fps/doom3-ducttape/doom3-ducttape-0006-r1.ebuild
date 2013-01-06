# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-ducttape/doom3-ducttape-0006-r1.ebuild,v 1.4 2009/10/07 14:39:00 nyhm Exp $

EAPI=2

MOD_DESC="sticks flashlights to your machinegun and shotgun"
MOD_NAME="Duct Tape"
MOD_DIR="ducttape"

inherit games games-mods

HOMEPAGE="http://ducttape.glenmurphy.com/"
SRC_URI="http://ducttape.glenmurphy.com/ducttape${PV}.zip"

LICENSE="as-is"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

src_unpack() {
	mkdir ${MOD_DIR}
	cd ${MOD_DIR}
	unpack ${A}
}

src_prepare() {
	rm -f ${MOD_DIR}/pak002.pk4 # for doom3-roe
}

pkg_postinst() {
	games-mods_pkg_postinst

	elog "To use old saved games with this mod, run:"
	elog " mkdir -p ~/.doom3/ducttape"
	elog " cp -r ~/.doom3/base/savegames ~/.doom3/ducttape"
}
