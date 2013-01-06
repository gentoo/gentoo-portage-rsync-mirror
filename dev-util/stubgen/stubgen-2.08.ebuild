# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/stubgen/stubgen-2.08.ebuild,v 1.1 2011/05/31 19:28:42 angelos Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="a member function stub generator for C++"
HOMEPAGE="http://www.radwin.org/michael/projects/stubgen/"
SRC_URI="http://www.radwin.org/michael/projects/${PN}/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	make CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LFLAGS="${LDFLAGS}"
}

src_install() {
	dobin ${PN}
	dodoc ChangeLog README
	doman ${PN}.1
}
