# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mawk/mawk-1.3.4_p20120627.ebuild,v 1.2 2012/10/10 21:59:04 ottxor Exp $

EAPI="4"

inherit toolchain-funcs eutils

MY_P=${P/_p/-}
DESCRIPTION="an (often faster than gawk) awk-interpreter"
HOMEPAGE="http://invisible-island.net/mawk/mawk.html"
SRC_URI="ftp://invisible-island.net/mawk/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND="app-admin/eselect-awk"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

DOCS=( ACKNOWLEDGMENT CHANGES README )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.3.4-cross-compile.patch
	tc-export BUILD_CC
}

src_install() {
	default

	exeinto /usr/share/doc/${PF}/examples
	doexe examples/*
	docompress -x /usr/share/doc/${PF}/examples
}

pkg_postinst() {
	eselect awk update ifunset
}

pkg_postrm() {
	eselect awk update ifunset
}
