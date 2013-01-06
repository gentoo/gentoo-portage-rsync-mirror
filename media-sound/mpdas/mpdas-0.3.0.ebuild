# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpdas/mpdas-0.3.0.ebuild,v 1.4 2012/05/05 08:39:20 mgorny Exp $

inherit base toolchain-funcs

DESCRIPTION="An AudioScrobbler client for MPD written in C++"
HOMEPAGE="http://50hz.ws/mpdas/"
SRC_URI="http://50hz.ws/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/libmpd
	net-misc/curl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile() {
	tc-export CXX
	emake CONFIG="/etc" || die "emake failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1 || die "doman failed"
	dodoc ChangeLog mpdasrc.example README || die "dodoc failed"
}

pkg_postinst() {
	elog "For further configuration help consult the README in"
	elog "${EPREFIX}/usr/share/doc/${PF}"
}
