# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.16.ebuild,v 1.2 2015/03/13 11:57:45 jer Exp $

EAPI=5

inherit eutils virtualx

MY_PN=Tcllib
MY_P=${MY_PN}-${PV}

DESCRIPTION="Tcl Standard Library"
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="mirror://sourceforge//project/${PN}/${PN}/${PV}/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
IUSE="examples"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"

RDEPEND="
	dev-lang/tcl
	dev-tcltk/tdom
	"
DEPEND="${RDEPEND}"

DOCS=( DESCRIPTION.txt STATUS )

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-test.patch \
		"${FILESDIR}"/${P}-XSS-vuln.patch
}

src_test() {
#	emake test_interactive
	#emake test_batch
	Xemake test_batch
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
