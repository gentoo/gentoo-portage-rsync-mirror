# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/pfl/pfl-2.3-r1.ebuild,v 1.4 2012/08/05 14:09:15 ryao Exp $

EAPI=4

PYTHON_DEPEND=2
PYTHON_USE_WITH=xml

inherit distutils python

DESCRIPTION="Searchable online file/package database for Gentoo"
HOMEPAGE="http://www.portagefilelist.de"
SRC_URI="http://files.portagefilelist.de/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~sparc ~x86 ~amd64-fbsd ~x64-freebsd"
IUSE="+network-cron"

DEPEND=""
RDEPEND="${DEPEND}
	net-misc/curl
	sys-apps/portage"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install

	if use network-cron ; then
		exeinto /etc/cron.weekly
		doexe cron/pfl
	fi

	keepdir /var/lib/${PN}
}

pkg_postinst() {
	python_mod_optimize ${PN}

	if [[ ! -e "${EROOT%/}/var/lib/${PN}/pfl.info" ]]; then
		touch "${EROOT%/}/var/lib/${PN}/pfl.info"
		chown -R 0:portage "${EROOT%/}/var/lib/${PN}"
		chmod 775 "${EROOT%/}/var/lib/${PN}"
	fi
}

pkg_postrm() {
	python_mod_cleanup ${PN}
}
