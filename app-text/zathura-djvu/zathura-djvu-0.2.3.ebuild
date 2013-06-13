# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-djvu/zathura-djvu-0.2.3.ebuild,v 1.1 2013/06/13 22:00:58 xmw Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="DjVu plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="cairo"

RDEPEND=">=app-text/djvu-3.5.24-r1
	>=app-text/zathura-0.2.0
	dev-libs/glib:2
	cairo? ( x11-libs/cairo )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	myzathuraconf=(
		WITH_CAIRO=$(usex cairo 1 0)
		CC="$(tc-getCC)"
		LD="$(tc-getLD)"
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}
