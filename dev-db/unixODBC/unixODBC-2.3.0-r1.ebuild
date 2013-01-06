# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.3.0-r1.ebuild,v 1.8 2011/04/16 15:48:53 armin76 Exp $

EAPI=3
inherit libtool eutils

DESCRIPTION="A complete ODBC driver manager"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="mirror://sourceforge/unixodbc/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris"
IUSE="+minimal odbcmanual static-libs"

RDEPEND=">=sys-devel/libtool-2.2.6b
	>=sys-libs/readline-6.0_p4
	>=sys-libs/ncurses-5.6-r2"
DEPEND="${RDEPEND}
	sys-devel/flex"

src_prepare() {
	epatch "${FILESDIR}/${P}-sqldriverconnect.patch"
	elibtoolize
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc/${PN}" \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_enable !minimal drivers) \
		$(use_enable !minimal driver-conf)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die

	if use prefix; then
		dodoc README* || die
	fi

	if use odbcmanual; then
		dohtml -a css,gif,html,sql,vsd -r doc/* || die
	fi
}
