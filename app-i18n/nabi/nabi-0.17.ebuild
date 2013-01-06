# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nabi/nabi-0.17.ebuild,v 1.5 2012/05/03 19:24:27 jdhore Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="Simple Hanguk X Input Method"
HOMEPAGE="http://nabi.kldp.net/"
SRC_URI="http://kldp.net/frs/download.php/3742/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=x11-libs/gtk+-2.2:2
	>=app-i18n/libhangul-0.0.4"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.99.3-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog "You MUST add environment variable..."
	elog
	elog "export XMODIFIERS=\"@im=nabi\""
	elog
}
