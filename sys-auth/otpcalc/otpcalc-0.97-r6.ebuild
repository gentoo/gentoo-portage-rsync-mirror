# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/otpcalc/otpcalc-0.97-r6.ebuild,v 1.1 2012/12/15 12:33:05 ulm Exp $

EAPI=5

inherit eutils

DESCRIPTION="A One Time Password and S/Key calculator for X"
HOMEPAGE="http://killa.net/infosec/otpCalc/"
SRC_URI="http://killa.net/infosec/otpCalc/otpCalc-${PV}.tar.gz"

LICENSE="GPL-2+" # bundled crypto functions are not used
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/openssl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/otpCalc-${PV}"

src_prepare() {
	epatch \
		"${FILESDIR}/${PN}-man-table-format.diff" \
		"${FILESDIR}/${P}-badindex.diff" \
		"${FILESDIR}/${PN}-crypto-proto.diff" \
		"${FILESDIR}/${P}-gtk2-gentoo.patch" \
		"${FILESDIR}/${P}-skey-md5.patch" \
		"${FILESDIR}/${P}-sha1-byteorder.patch" \
		"${FILESDIR}/${P}-gtk-deprecated.patch"

	# print correct version in manpage
	sed -i -e "s/VERSION/${PV}/g" otpCalc.man || die

	# override hardcoded FLAGS
	sed -i \
		-e 's:$(CC) $(CFLAGS) $^:$(CC) $(LDFLAGS) $(CFLAGS) $^:' \
		-e "s#-s -O3#${CFLAGS}#g" \
		Makefile.in || die
}

src_install() {
	dobin otpCalc
	dosym otpCalc /usr/bin/otpcalc
	newman otpCalc.man otpCalc.1
	domenu "${FILESDIR}/${PN}.desktop"
	dodoc BUGS ChangeLog TODO
}
