# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arm/arm-1.4.4.1.ebuild,v 1.4 2012/02/24 15:01:05 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
PYTHON_USE_WITH="ncurses"

inherit python distutils

DESCRIPTION="A ncurses-based status monitor for Tor relays"
HOMEPAGE="http://www.atagar.com/arm/"
SRC_URI="http://www.atagar.com/arm/resources/static/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=net-misc/tor-0.2.1.27"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install --docPath "${EPREFIX}"/usr/share/doc/${PF}
}

pkg_postinst() {
	elog "Some graphing data issues have been noted in testing"
	elog "when run as root. It is not recommended to run arm as"
	elog "root until those issues have been isolated and fixed."
	elog
	elog "Trouble with graphs under app-misc/screen? Try:"
	elog 'TERM="rxvt-unicode" arm'
}
