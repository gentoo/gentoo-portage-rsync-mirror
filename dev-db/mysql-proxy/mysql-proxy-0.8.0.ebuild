# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-proxy/mysql-proxy-0.8.0.ebuild,v 1.3 2012/05/03 02:33:10 jdhore Exp $

EAPI=2

inherit eutils

DESCRIPTION="A Proxy for the MySQL Client/Server protocol"
HOMEPAGE="http://forge.mysql.com/wiki/MySQL_Proxy"
SRC_URI="mirror://mysql/Downloads/MySQL-Proxy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
RDEPEND=">=dev-libs/libevent-1.4
	>=dev-libs/glib-2.16
	>=dev-lang/lua-5.1"
DEPEND="${RDEPEND}
	>=virtual/mysql-5.0
	virtual/pkgconfig"
RESTRICT="test"

src_configure() {
	econf \
		--includedir=/usr/include/${PN} \
		--with-mysql \
		--with-lua \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die
	newconfd "${FILESDIR}"/${PN}.confd ${PN} || die
	dodoc ChangeLog NEWS README
	if use examples; then
		docinto examples
		dodoc examples/*.lua
	fi
}

pkg_postinst() {
	einfo
	einfo "You might want to have a look at"
	einfo "http://dev.mysql.com/tech-resources/articles/proxy-gettingstarted.html"
	einfo "on how to get started with MySQL Proxy."
	einfo
}
