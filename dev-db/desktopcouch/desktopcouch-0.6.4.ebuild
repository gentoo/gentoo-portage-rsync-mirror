# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/desktopcouch/desktopcouch-0.6.4.ebuild,v 1.3 2011/01/08 16:35:16 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils eutils multilib

DESCRIPTION="Desktop-oriented interface to CouchDB"
HOMEPAGE="https://launchpad.net/desktopcouch"
SRC_URI="http://launchpad.net/desktopcouch/trunk/${PV}/+download/${P}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-python/python-distutils-extra-2.12"
RDEPEND=">=dev-db/couchdb-0.10.0
	>=dev-python/gnome-keyring-python-2.22.3-r1
	<dev-python/couchdb-python-0.7
	>=dev-python/oauth-1.0.1
	>=dev-python/simplejson-2.0.9-r1
	>=dev-python/twisted-8.2.0-r2
	>=net-dns/avahi-0.6.24-r2[python]"
RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}/${P}-setup_hardlinks.patch"
}

src_install() {
	python_convert_shebangs -r 2 "bin/"

	distutils_src_install

	exeinto "/usr/$(get_libdir)/${PN}"
	doexe "bin/desktopcouch-stop"
	doexe "bin/desktopcouch-service"
	doexe "bin/desktopcouch-get-port"

	if use doc; then
		insinto "/usr/share/doc/${PF}/api"
		doins "desktopcouch/records/doc/records.txt"
		doins "desktopcouch/records/doc/field_registry.txt"
		doins "desktopcouch/contacts/schema.txt"

		doman "docs/man/desktopcouch-pair.1"
	fi
}
