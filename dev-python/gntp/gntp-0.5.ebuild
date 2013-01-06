# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gntp/gntp-0.5.ebuild,v 1.2 2012/01/15 22:04:25 hwoarang Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Python library for working with the Growl Notification Transport Protocol"
HOMEPAGE="https://github.com/kfdm/gntp http://pypi.python.org/pypi/gntp"
SRC_URI="https://github.com/kfdm/gntp/tarball/${PV} -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default
	mv * ${P}
}
