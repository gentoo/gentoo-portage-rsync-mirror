# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xapian-omega/xapian-omega-1.2.13.ebuild,v 1.1 2013/01/11 03:05:56 blueness Exp $

EAPI="4"

DESCRIPTION="An application built on Xapian, consisting of indexers and a CGI search frontend"
SRC_URI="http://www.oligarchy.co.uk/xapian/${PV}/xapian-omega-${PV}.tar.gz"
HOMEPAGE="http://www.xapian.org/"
S="${WORKDIR}/xapian-omega-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-libs/xapian-${PV}
	dev-lang/perl
	dev-libs/libpcre
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_install () {
	emake DESTDIR="${D}" install

	#move docs to /usr/share/doc/${PF}.
	mv "${D}/usr/share/doc/xapian-omega" "${D}/usr/share/doc/${PF}"

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
