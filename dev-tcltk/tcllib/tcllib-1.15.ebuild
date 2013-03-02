# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.15.ebuild,v 1.2 2013/03/02 17:49:01 jlec Exp $

EAPI=5

inherit eutils

DESCRIPTION="Tcl Standard Library"
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="mirror://sourceforge/tcllib/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
IUSE="examples"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~s390 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"

RDEPEND="dev-lang/tcl"
DEPEND="${RDEPEND}"

DOCS=( DESCRIPTION.txt STATUS )

src_prepare() {
	epatch "${FILESDIR}"/${P}-tcl8.6-test.patch
}

src_test() {
#	emake test_interactive
	emake test_batch
}

src_install() {
	default

	rm "${ED}"/usr/share/man/mann/{try,string,variable,zlib}.n || die

	dodoc devdoc/*.txt

	dohtml devdoc/*.html
	if use examples ; then
		for f in $(find examples -type f); do
			docinto $(dirname $f)
			dodoc $f
		done
	fi
}
