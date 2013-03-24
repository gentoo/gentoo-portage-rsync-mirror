# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/automx/automx-0.8-r1.ebuild,v 1.2 2013/03/24 19:11:12 vincent Exp $

EAPI=4
PYTHON_DEPEND="2:2.6:2.7"
SUPPORT_PYTHON_ABIS="1"
inherit python

DESCRIPTION="A mail user agent auto configuration service"
HOMEPAGE="http://www.automx.org"
SRC_URI="${HOMEPAGE}/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc sql +tools"

DEPEND=""
RDEPEND="
	dev-python/lxml
	|| ( www-apache/mod_wsgi www-servers/uwsgi )
	sql? ( dev-python/sqlalchemy )
	tools? ( net-dns/bind-tools )
	tools? ( net-misc/wget )
	"

RESTRICT_PYTHON_ABIS="2.[45] 3.*"

#src_prepare() {
#	python_copy_sources
#	python_src_prepare
#}

src_install() {
	dodoc INSTALL CREDITS

	if use doc; then
		dohtml -r doc/html/*

		docinto examples
		dodoc doc/examples/*
	fi

	doman doc/man/man5/*

	if use tools; then
		exeinto /usr/bin
		doexe src/automx-test
		doman doc/man/man1/automx-test.1
	fi

	exeinto /usr/lib/${PN}
	doexe src/automx.wsgi

	insinto /etc
	doins src/automx.conf

	installation() {
		insinto $(python_get_sitedir)/${PN}
		doins src/automx/*
	}
	python_execute_function installation
}

pkg_postinst() {
	python_mod_optimize ${PN}
	einfo
	einfo "See /usr/share/doc/${PF}/INSTALL.bz2 for setup instructions"
	einfo
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
