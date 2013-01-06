# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/xca/xca-0.9.1.ebuild,v 1.1 2012/11/04 21:48:59 c1pher Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A GUI to OpenSSL, RSA public keys, certificates, signing requests and revokation lists"
HOMEPAGE="http://www.hohnstaedt.de/xca.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

RDEPEND=">=dev-libs/openssl-0.9.8[-bindist]
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	doc? ( app-text/linuxdoc-tools )"

src_prepare() {
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1800298&group_id=62274&atid=500028
	epatch "${FILESDIR}"/${PN}-0.9.0-qt_detection.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_configure() {
	local LINUXDOC
	use doc || LINUXDOC='touch $@ && true'

	QTDIR="${EPREFIX}/usr" \
		STRIP="true" \
		LINUXDOC="${LINUXDOC}" \
		CC="$(tc-getCXX)" \
		LD="$(tc-getLD)" \
		CFLAGS="${CXXFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		prefix="${EPREFIX}/usr" \
		docdir="${EPREFIX}/usr/share/doc/${PF}" \
		./configure || die	"configure failed"
}

src_install() {
	emake destdir="${D}" mandir="share/man" install

	dodoc AUTHORS

	insinto /etc/xca
	doins misc/*.txt
}
