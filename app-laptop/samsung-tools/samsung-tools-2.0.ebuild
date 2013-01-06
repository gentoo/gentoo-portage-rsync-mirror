# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/samsung-tools/samsung-tools-2.0.ebuild,v 1.1 2011/12/18 10:12:20 angelos Exp $

EAPI=4
PYTHON_DEPEND=2
inherit fdo-mime python

DESCRIPTION="Tools for Samsung laptops"
HOMEPAGE="http://launchpad.net/samsung-tools"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-laptop/easy-slow-down-manager
	dev-python/dbus-python
	dev-python/notify-python
	dev-python/pygtk
	net-wireless/rfkill
	sys-power/pm-utils
	x11-misc/xbindkeys"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r -q 2 .
}

src_compile() {
	return
}

src_install() {
	emake DESTDIR="${D}" install
	newinitd "${FILESDIR}"/${PN}.init ${PN}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	python_mod_optimize /usr/lib/${PN}
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	python_mod_cleanup /usr/lib/${PN}
}
