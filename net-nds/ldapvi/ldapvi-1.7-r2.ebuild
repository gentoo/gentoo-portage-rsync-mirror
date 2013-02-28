# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ldapvi/ldapvi-1.7-r2.ebuild,v 1.1 2013/02/28 09:29:22 xmw Exp $

EAPI=5

inherit autotools eutils

DESCRIPTION="Manage LDAP entries with a text editor"
HOMEPAGE="http://www.lichteblau.com/ldapvi/"
SRC_URI="http://www.lichteblau.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="ssl"

RDEPEND="sys-libs/ncurses
	>=net-nds/openldap-2.2
	dev-libs/popt
	>=dev-libs/glib-2
	sys-libs/readline
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}/${P}+glibc-2.10.patch"
	epatch "${FILESDIR}/${P}-vim-encoding.patch"

	sed -e '/^AC_SEARCH_LIBS/s:curses ncurses:curses ncurses tinfo:' \
		-i configure.in || die
	eautoreconf
}

src_configure() {
	econf $(use_with ssl libcrypto openssl)
}

src_install() {
	dobin ldapvi
	doman ldapvi.1
	dodoc NEWS manual/{bg.png,html.xsl,manual.{css,xml}}
}
