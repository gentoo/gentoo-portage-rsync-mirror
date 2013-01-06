# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mathtex/mathtex-1.03.ebuild,v 1.1 2009/12/21 20:34:57 pva Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="MathTeX lets you easily embed LaTeX math in your own html pages, blogs, wikis, etc"
HOMEPAGE="http://www.forkosh.com/mathtex.html"
SRC_URI="http://www.forkosh.com/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/dvipng
	virtual/latex-base"
DEPEND=""

einfo_run_command() {
	einfo "${@}"
	${@} || die
}

src_compile() {
	einfo_run_command $(tc-getCC) \
		${CFLAGS} ${LDFLAGS} \
		-DLATEX=\"/usr/bin/latex\" \
		-DDVIPNG=\"/usr/bin/dvipng\" \
		 mathtex.c -o mathtex
}

src_install() {
	dobin mathtex || die
	dodoc README || die
	dohtml mathtex.html || die
}

pkg_postinst() {
	elog "To use mathtex in your web-pages, just link /usr/bin/mathtex"
	elog "to your cgi-bin subdirectory!"
}
