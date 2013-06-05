# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/xca/xca-0.9.3-r1.ebuild,v 1.2 2013/06/05 08:27:23 nimiux Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A GUI to OpenSSL, RSA public keys, certificates, signing requests and revokation lists"
HOMEPAGE="http://www.hohnstaedt.de/xca.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc bindist"

RDEPEND=">=dev-libs/openssl-0.9.8[bindist=]
	dev-qt/qtgui:4"
DEPEND="${RDEPEND}
	doc? ( app-text/linuxdoc-tools )"

src_prepare() {
	# http://sourceforge.net/tracker/index.php?func=detail&aid=1800298&group_id=62274&atid=500028
	epatch "${FILESDIR}"/${PN}-0.9.0-qt_detection.patch
	epatch "${FILESDIR}"/${PN}-0.9.1-ldflags.patch
	epatch "${FILESDIR}"/${P}-desktop.patch
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
