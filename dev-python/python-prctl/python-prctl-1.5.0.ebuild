# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-prctl/python-prctl-1.5.0.ebuild,v 1.1 2013/01/24 08:55:36 patrick Exp $

EAPI=3

PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Control process attributes through prctl"
HOMEPAGE="http://github.com/seveas/python-prctl"
SRC_URI="http://github.com/seveas/${PN}/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/libcap"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="prctl.py"

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}
