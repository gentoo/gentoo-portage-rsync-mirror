# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-pdf-mupdf/zathura-pdf-mupdf-9999.ebuild,v 1.3 2013/06/19 14:22:58 xmw Exp $

EAPI=5

inherit eutils git-2 toolchain-funcs

DESCRIPTION="PDF plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
EGIT_REPO_URI="git://git.pwmt.org/${PN}.git"
EGIT_BRANCH="mupdf-git"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="!app-text/zathura-pdf-poppler
	>=app-text/mupdf-9999:=
	>=app-text/zathura-0.2.0
	media-libs/jbig2dec
	media-libs/openjpeg:2
	virtual/jpeg
	x11-libs/cairo:="
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	# does not render w/o cairo
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
