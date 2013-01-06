# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tkman/tkman-2.2-r1.ebuild,v 1.7 2012/09/05 07:17:12 jlec Exp $

EAPI=2
inherit eutils

DESCRIPTION="TkMan man and info page browser"
HOMEPAGE="http://tkman.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

DEPEND=">=app-text/rman-3.1
	>=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.2-gentoo.diff
	epatch "${FILESDIR}"/${PN}-CVE-2008-5137.diff #bug 247540
}

src_install() {
	dodir /usr/bin
	make DESTDIR="${D}" install || die

	dodoc ANNOUNCE-tkman.txt CHANGES README-tkman manual.html

	insinto /usr/share/icons
	doins contrib/TkMan.gif

	domenu "${FILESDIR}"/tkman.desktop
}
