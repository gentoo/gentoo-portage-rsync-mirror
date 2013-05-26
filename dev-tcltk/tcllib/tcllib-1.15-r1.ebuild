# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.15-r1.ebuild,v 1.8 2013/05/26 15:56:47 ago Exp $

EAPI=5

inherit eutils

DESCRIPTION="Tcl Standard Library"
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="
	http://dev.gentoo.org/~jlec/distfiles/${P}-manpage-rename.patch.xz
	http://dev.gentoo.org/~jlec/distfiles/${P}-test.patch.xz
	mirror://sourceforge/tcllib/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
IUSE="examples"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~s390 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"

RDEPEND="dev-lang/tcl"
DEPEND="${RDEPEND}"

DOCS=( DESCRIPTION.txt STATUS )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-tcl8.6-test.patch \
		"${WORKDIR}"/${P}-test.patch \
		"${WORKDIR}"/${P}-manpage-rename.patch
}

src_test() {
#	emake test_interactive
	emake test_batch
}

src_install() {
	default

	dodoc devdoc/*.txt

	dohtml devdoc/*.html
	if use examples ; then
		for f in $(find examples -type f); do
			docinto $(dirname $f)
			dodoc $f
		done
	fi
}
