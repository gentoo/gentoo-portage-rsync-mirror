# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/ms-sys/ms-sys-2.3.0.ebuild,v 1.3 2012/08/10 14:16:42 johu Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="A command-line program for writing Microsoft compatible boot records."
HOMEPAGE="http://ms-sys.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="linguas_sv"

DEPEND="sys-devel/gettext"
RDEPEND="virtual/libintl"

src_compile() {
	tc-export CC
	default
}

src_install() {
	local nls=""
	if ! use linguas_sv ; then
		nls='NLS_FILES='
	fi

	emake DESTDIR="${D}" MANDIR="/usr/share/man" \
		PREFIX="/usr" ${nls} install

	dodoc CHANGELOG CONTRIBUTORS FAQ README TODO
}
