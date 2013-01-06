# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/tinymount/tinymount-0.2.4.ebuild,v 1.2 2012/05/15 11:37:37 ssuominen Exp $

EAPI=4

unset _live_inherits

LANGS="ru"

if [[ ${PV} == *9999* ]]; then
	_live_inherits="git-2"
	EGIT_REPO_URI="git://github.com/limansky/${PN}.git"
else
	SRC_URI="mirror://github/limansky/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

inherit qt4-r2 ${_live_inherits}

DESCRIPTION="Simple disk mount utility"
HOMEPAGE="http://github.com/limansky/tinymount"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug libnotify"

COMMON_DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-dbus:4
	libnotify? ( x11-libs/libnotify )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	sys-fs/udisks:0"

src_configure() {
	local params="PREFIX=/usr"
	use libnotify && params="${params} CONFIG+=with_libnotify"
	eqmake4 ${params}
}

src_install() {
	qt4-r2_src_install

	local lang
	for lang in ${LANGS}; do
		if ! has ${lang} ${LINGUAS}; then
			rm "${D}"/usr/share/${PN}/${PN}_${lang}.qm || die
		fi
	done

	dodoc ChangeLog README.md
}
