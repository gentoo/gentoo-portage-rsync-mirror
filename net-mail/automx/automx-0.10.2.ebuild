# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/automx/automx-0.10.2.ebuild,v 1.2 2014/09/17 12:48:05 mschiff Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1

DESCRIPTION="A mail user agent auto configuration service"
HOMEPAGE="http://www.automx.org"
SRC_URI="https://github.com/sys4/${PN}/archive/v${PV}.tar.gz -> automx-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap memcached sql +tools"

DEPEND="${PYTHON_DEPS}"
RDEPEND="
	${DEPEND}
	dev-python/ipaddr[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	|| ( www-apache/mod_wsgi[${PYTHON_USEDEP}] www-servers/uwsgi )
	ldap? ( dev-python/python-ldap[${PYTHON_USEDEP}]  )
	memcached? ( dev-python/python-memcached )
	sql? ( dev-python/sqlalchemy[${PYTHON_USEDEP}] )
	tools? ( net-dns/bind-tools net-misc/wget )
	"

src_prepare() {
	sed -i '/py_modules=/d' setup.py
}

src_install() {
	distutils-r1_src_install

	dodoc INSTALL CREDITS CHANGES BASIC_CONFIGURATION_README
	dohtml -r doc/html/*

	docinto examples
	dodoc src/conf/*example*

	doman doc/man/man5/*

	if use tools; then
		exeinto /usr/bin
		doexe src/automx-test
		doman doc/man/man1/automx-test.1
	fi

	exeinto /usr/lib/${PN}
	doexe src/automx_wsgi.py
}

pkg_postinst() {
	einfo
	einfo "See /usr/share/doc/${PF}/INSTALL.bz2 for setup instructions"
	einfo
}
