# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mozrunner/mozrunner-5.17.ebuild,v 1.1 2013/06/13 08:18:29 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Reliable start/stop/configuration of Mozilla Applications (Firefox, Thunderbird, etc.)"
HOMEPAGE="http://pypi.python.org/pypi/mozrunner"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/simplejson
	>=dev-python/mozinfo-0.3.3
	>=dev-python/mozprocess-0.7
	>=dev-python/mozprofile-0.4
	dev-python/setuptools"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e 's/\(moz.*\) ==/\1 >=/' -i setup.py
	distutils_src_prepare
}
