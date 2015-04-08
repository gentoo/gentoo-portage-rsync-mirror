# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-fastimport/python-fastimport-0.9.2.ebuild,v 1.3 2012/08/11 09:29:36 ago Exp $

EAPI="4"

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Library for parsing the fastimport VCS serialization format"
HOMEPAGE="https://launchpad.net/python-fastimport"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND=""

PYTHON_MODNAME="fastimport"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}
