# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/irsim/irsim-9.7.72.ebuild,v 1.1 2011/04/26 18:07:29 tomjbe Exp $

EAPI="2"

inherit eutils

DESCRIPTION="IRSIM is a \"switch-level\" simulator"
HOMEPAGE="http://opencircuitdesign.com/irsim/"
SRC_URI="http://opencircuitdesign.com/irsim/archive/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=" dev-lang/tcl
	dev-lang/tk"
DEPEND="${RDEPEND}
	app-shells/tcsh"

src_prepare() {
	sed -i -e "s: -pg : :" tcltk/Makefile || die
	epatch "${FILESDIR}"/${P}-ldflags.patch
}

src_configure() {
	# Short-circuit top-level configure script to retain CFLAGS
	cd scripts
	CPP="cpp" econf --libdir=/usr/share
	cd ..
}

src_install() {
	emake DESTDIR="${D}" DOCDIR=/usr/share/doc/${PF} install || die
	dodoc README || die
}

pkg_postinst() {
	einfo
	einfo "You will probably need to add to your ~/.Xdefaults"
	einfo "the following line:"
	einfo "irsim.background: black"
	einfo
	einfo "This is needed because Gentoo from default sets a"
	einfo "grey background which makes impossible to see the"
	einfo "simulation (white line on light gray background)."
	einfo
}
