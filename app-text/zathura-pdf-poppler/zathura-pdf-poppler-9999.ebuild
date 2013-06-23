# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-pdf-poppler/zathura-pdf-poppler-9999.ebuild,v 1.1 2013/06/23 12:53:52 xmw Exp $

EAPI=5

inherit eutils git-2 toolchain-funcs

DESCRIPTION="PDF plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
EGIT_REPO_URI="git://git.pwmt.org/${PN}.git"
EGIT_BRANCH="develop"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE="+deprecated"

RDEPEND="app-text/poppler:=[cairo]
	>=app-text/zathura-0.2.0[deprecated=]
	x11-libs/cairo:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	#cairo is non-optional #473378
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
