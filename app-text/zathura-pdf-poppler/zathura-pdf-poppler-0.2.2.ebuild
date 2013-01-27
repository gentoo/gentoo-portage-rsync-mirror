# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-pdf-poppler/zathura-pdf-poppler-0.2.2.ebuild,v 1.2 2013/01/27 21:54:41 ssuominen Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="PDF plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND="app-text/poppler[cairo]
	>=app-text/zathura-0.2.2
	>=dev-libs/girara-0.1.5:2
	x11-libs/cairo"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	myzathuraconf=(
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
