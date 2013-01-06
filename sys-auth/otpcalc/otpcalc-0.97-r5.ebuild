# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/otpcalc/otpcalc-0.97-r5.ebuild,v 1.8 2012/05/04 18:57:20 jdhore Exp $

EAPI=3

inherit eutils

DESCRIPTION="A One Time Password and S/Key calculator for X"
HOMEPAGE="http://killa.net/infosec/otpCalc/"
SRC_URI="http://killa.net/infosec/otpCalc/otpCalc-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/openssl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/otpCalc-${PV}"

src_prepare() {
	epatch "${FILESDIR}/${PN}-man-table-format.diff"
	epatch "${FILESDIR}/${P}-badindex.diff"
	epatch "${FILESDIR}/${PN}-crypto-proto.diff"

	# make it work with GTK+ 2
	epatch "${FILESDIR}/${P}-gtk2-gentoo.patch"

	# change default s/key hash to MD5 (same as sys-auth/skey)
	epatch "${FILESDIR}/${P}-skey-md5.patch"

	# fix SHA1 byte-order issue for conformance with RFC 2289
	epatch "${FILESDIR}/${P}-sha1-byteorder.patch"

	# print correct version in manpage
	sed -i -e "s/VERSION/${PV}/g" otpCalc.man || die

	# override hardcoded FLAGS
	sed -i \
		-e 's:$(CC) $(CFLAGS) $^:$(CC) $(LDFLAGS) $(CFLAGS) $^:' \
		-e "s#-s -O3#${CFLAGS}#g" \
		Makefile.in || die
}

src_install() {
	dobin otpCalc || die
	dosym otpCalc /usr/bin/otpcalc || die
	newman otpCalc.man otpCalc.1 || die
	domenu "${FILESDIR}/${PN}.desktop" || die
	dodoc BUGS ChangeLog TODO || die
}
