# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/trojita/trojita-9999.ebuild,v 1.11 2012/11/28 07:37:32 yngwin Exp $

EAPI=4

QT_REQUIRED="4.6.0"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"
[[ ${PV} == "9999" ]] && GIT_ECLASS="git-2"
inherit qt4-r2 ${GIT_ECLASS}

DESCRIPTION="A Qt IMAP e-mail client"
HOMEPAGE="http://trojita.flaska.net/"
if [[ ${PV} == "9999" ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
IUSE="debug test +zlib"

RDEPEND="
	>=x11-libs/qt-gui-${QT_REQUIRED}:4
	>=x11-libs/qt-sql-${QT_REQUIRED}:4[sqlite]
	>=x11-libs/qt-webkit-${QT_REQUIRED}:4
"
DEPEND="${RDEPEND}
	test? ( >=x11-libs/qt-test-${QT_REQUIRED}:4 )
	zlib? (
		virtual/pkgconfig
		sys-libs/zlib
	)
"

src_configure() {
	local myopts=""
	use debug && myopts="$myopts CONFIG+=debug"
	use test || myopts="$myopts CONFIG+=disable_tests"
	use zlib || myopts="$myopts CONFIG+=disable_zlib"
	eqmake4 PREFIX=/usr $myopts
}
