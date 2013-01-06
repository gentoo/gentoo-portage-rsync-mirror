# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/kanjipad/kanjipad-1.2.3.ebuild,v 1.9 2011/03/27 10:53:08 nirbheek Exp $

EAPI="1"

DESCRIPTION="Japanese handwriting recognition tool"
HOMEPAGE="http://www.gtk.org/~otaylor/kanjipad/"
SRC_URI="ftp://ftp.gtk.org/pub/users/otaylor/kanjipad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-1.2.10-r8:1
	>=dev-libs/glib-1.2.10-r4:1"

src_compile() {
	mv Makefile Makefile.orig
	sed -e "s/PREFIX=\/usr\/local/PREFIX=\/usr/" Makefile.orig > Makefile

	emake || die
}

src_install() {
	dobin kanjipad kpengine || die
	insinto /usr/share/kanjipad
	doins jdata.dat || die
}
