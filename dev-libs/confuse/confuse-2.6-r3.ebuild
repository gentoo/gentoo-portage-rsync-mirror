# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/confuse/confuse-2.6-r3.ebuild,v 1.8 2012/05/04 18:35:53 jdhore Exp $

inherit eutils

DESCRIPTION="a configuration file parser library"
HOMEPAGE="http://www.nongnu.org/confuse/"
SRC_URI="http://bzero.se/confuse/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="nls"

DEPEND="sys-devel/flex
	sys-devel/libtool
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug #236347
	epatch "${FILESDIR}"/${P}-O0.patch
	# bug 239020
	epatch "${FILESDIR}"/${P}-solaris.patch
	# drop -Werror, bug #208095
	sed -i -e 's/-Werror//' */Makefile.* || die
}

src_compile() {
	econf --enable-shared || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	doman doc/man/man3/*.3
	dodoc AUTHORS NEWS README
	dohtml doc/html/* || die
}
