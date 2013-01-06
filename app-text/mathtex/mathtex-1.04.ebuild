# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mathtex/mathtex-1.04.ebuild,v 1.3 2011/08/24 19:49:56 maekke Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="MathTeX lets you easily embed LaTeX math in your own html pages, blogs, wikis, etc"
HOMEPAGE="http://www.forkosh.com/mathtex.html"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="png"

RDEPEND="app-text/dvipng
	virtual/latex-base"
DEPEND=""

S=${WORKDIR}

einfo_run_command() {
	einfo "${@}"
	${@} || die
}

src_compile() {
	einfo_run_command $(tc-getCC) \
		${CFLAGS} ${LDFLAGS} \
		-DLATEX=\"/usr/bin/latex\" \
		-DDVIPNG=\"/usr/bin/dvipng\" \
		$(use png && echo "-DPNG") \
		 mathtex.c -o mathtex
}

src_install() {
	dobin mathtex
	dodoc README
	dohtml mathtex.html
}

pkg_postinst() {
	elog "To use mathtex in your web-pages, just link /usr/bin/mathtex"
	elog "to your cgi-bin subdirectory!"
}
