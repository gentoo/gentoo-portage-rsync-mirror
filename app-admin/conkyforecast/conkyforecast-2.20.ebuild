# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/conkyforecast/conkyforecast-2.20.ebuild,v 1.1 2011/10/27 14:08:19 xmw Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Conky weather forecast script with support for language files"
HOMEPAGE="https://launchpad.net/~conky-companions"
SRC_URI="https://launchpad.net/~conky-companions/+archive/ppa/+files/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-admin/conky"

S=${WORKDIR}/src

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e "s:/usr/bin/python:$(PYTHON -a):" conkyForecast || die
	distutils_src_prepare
}

pkg_postinst() {
	distutils_pkg_postinst

	elog "You have to define a partner id and registration code for "
	elog "the weather.com xoap. You need to copy the template from"
	elog "/usr/share/conkyforecast/conkyForecast.config into you account"
	elog "as ~/.conkyForecast.config and edit the respective fields."
	elog
	elog "More details can be found in the README file."
}
