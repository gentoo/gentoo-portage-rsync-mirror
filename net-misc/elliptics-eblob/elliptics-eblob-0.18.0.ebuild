# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/elliptics-eblob/elliptics-eblob-0.18.0.ebuild,v 1.2 2013/08/15 03:34:26 patrick Exp $

EAPI=5
PYTHON_COMPAT="python2_7"

inherit eutils python-single-r1 flag-o-matic cmake-utils

DESCRIPTION="The elliptics network - eblob backend"
HOMEPAGE="http://www.ioremap.net/projects/elliptics"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"
RDEPEND="
	app-arch/snappy
	dev-libs/openssl
	dev-libs/boost[python]"
DEPEND="${RDEPEND}"

MY_PN="eblob"
SRC_URI="http://dev.gentoo.org/~patrick/${MY_PN}-${PV}.tar.bz2"

S=${WORKDIR}/${MY_PN}-${PV}

src_configure(){
	# 'checking trying to link with boost::python... no' due '-Wl,--as-needed'
	use python && filter-ldflags -Wl,--as-needed
	cmake-utils_src_configure
}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	cmake-utils_src_install
	mkdir -p "${D}/$(python_get_sitedir)"
	cp bindings/python/python/eblob.py "${D}/$(python_get_sitedir)" || die "Fail"
}
