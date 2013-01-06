# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdemu/cdemu-1.4.0.ebuild,v 1.2 2012/01/18 12:08:27 ago Exp $

EAPI="4"
PYTHON_DEPEND="2"

inherit python

DESCRIPTION="Command-line tool for controlling the CDEmu daemon (cdemud)"
HOMEPAGE="http://cdemu.org"
SRC_URI="mirror://sourceforge/cdemu/cdemu-client-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+cdemud"

RDEPEND="dev-python/dbus-python
	cdemud? ( >=app-cdr/cdemud-1.4.0 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21"

S=${WORKDIR}/cdemu-client-${PV}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 src
}
