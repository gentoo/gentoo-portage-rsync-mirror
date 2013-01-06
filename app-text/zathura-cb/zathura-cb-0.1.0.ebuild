# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-cb/zathura-cb-0.1.0.ebuild,v 1.3 2012/07/11 05:52:38 jdhore Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="Comic book plug-in for zathura with 7zip, rar, tar and zip support"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

COMMON_DEPEND=">=app-text/zathura-0.2.0
	>=dev-libs/girara-0.1.3:2
	>=dev-libs/glib-2
	x11-libs/cairo"
RDEPEND="${COMMON_DEPEND}
	app-arch/p7zip
	app-arch/tar
	app-arch/unrar
	app-arch/unzip"
DEPEND="${COMMON_DEPEND}
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
