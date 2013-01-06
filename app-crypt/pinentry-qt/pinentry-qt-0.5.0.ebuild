# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/pinentry-qt/pinentry-qt-0.5.0.ebuild,v 1.2 2010/09/30 13:52:14 ssuominen Exp $

EAPI=2
inherit cmake-utils

DESCRIPTION="A simple PIN or passphrase entry dialog"
HOMEPAGE="http://gnupg.org/aegypten2/index.html"
SRC_URI="mirror://gnupg/pinentry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/eselect-pinentry
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README THANKS"

pkg_postinst() {
	eselect pinentry update ifunset
}

pkg_postrm() {
	eselect pinentry update ifunset
}
