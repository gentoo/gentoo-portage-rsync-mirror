# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/os-autoinst/os-autoinst-9999.ebuild,v 1.4 2012/11/08 13:29:38 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://gitorious.org/os-autoinst/os-autoinst.git"

inherit git-2 autotools

DESCRIPTION="automated testing of Operating Systems"
HOMEPAGE="http://os-autoinst.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-lang/perl[ithreads]
	app-emulation/qemu
	app-text/gocr
	media-gfx/imagemagick
	media-video/ffmpeg2theora

"
DEPEND=""

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}
