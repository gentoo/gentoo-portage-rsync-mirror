# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysql-proxy/mysql-proxy-0.8.2-r1.ebuild,v 1.1 2015/02/01 18:19:07 neurogeek Exp $

EAPI=5

inherit eutils

DESCRIPTION="A Proxy for the MySQL Client/Server protocol"
HOMEPAGE="http://forge.mysql.com/wiki/MySQL_Proxy"
SRC_URI="mirror://mysql/Downloads/MySQL-Proxy/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
RDEPEND=">=dev-libs/libevent-2.1
	>=dev-libs/glib-2.16
	>=dev-lang/lua-5.1"
DEPEND="${RDEPEND}
	>=virtual/mysql-5.0
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e 's|_EVENT_VERSION|LIBEVENT_VERSION|g' \
			src/chassis-mainloop.c || die
}

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
	newconfd "${FILESDIR}"/${PN}.confd-0.8.0-r1 ${PN} || die
	dodoc ChangeLog NEWS README
	if use examples; then
		docinto examples
		dodoc examples/*.lua || die
		dodoc lib/*.lua || die
	fi
	# mysql-proxy will refuse to start unless the config file is at most 0660.
	insinto /etc/mysql
	insopts -m0660
	doins "${FILESDIR}"/${PN}.cnf || die
}

pkg_postinst() {
	einfo
	einfo "You might want to have a look at"
	einfo "http://dev.mysql.com/tech-resources/articles/proxy-gettingstarted.html"
	einfo "on how to get started with MySQL Proxy."
	einfo
}
