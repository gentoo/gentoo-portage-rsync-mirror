# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-cb/zathura-cb-0.1.1.ebuild,v 1.4 2014/02/24 02:23:02 phajdan.jr Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="Comic book plug-in for zathura with 7zip, rar, tar and zip support"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/plugins/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm x86"
IUSE=""

COMMON_DEPEND=">=app-text/zathura-0.2.0
	dev-libs/glib:2
	app-arch/libarchive:=
	x11-libs/cairo:="
RDEPEND="${COMMON_DEPEND}
	app-arch/p7zip
	app-arch/tar
	app-arch/unrar
	app-arch/unzip"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"

pkg_setup() {
	#does not render w/o cairo
	myzathuraconf=(
		WITH_CAIRO=1
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
