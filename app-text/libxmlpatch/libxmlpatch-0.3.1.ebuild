# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libxmlpatch/libxmlpatch-0.3.1.ebuild,v 1.3 2012/05/04 03:33:13 jdhore Exp $

inherit eutils autotools

DESCRIPTION="A set of tools to create and apply patch to XML files using XPath"
HOMEPAGE="http://xmlpatch.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/lib}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/glib"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-asneeded.patch"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc LEGAL_NOTICE README TODO AUTHORS NEWS ChangeLog
}
