# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beanstalkc/beanstalkc-0.2.0.ebuild,v 1.5 2010/10/30 19:24:41 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A simple beanstalkd client library"
HOMEPAGE="http://github.com/earl/beanstalkc http://pypi.python.org/pypi/beanstalkc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/pyyaml"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

DOCS="README"
PYTHON_MODNAME="beanstalkc.py"
