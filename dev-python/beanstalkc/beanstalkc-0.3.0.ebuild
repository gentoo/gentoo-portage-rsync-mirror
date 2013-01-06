# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/beanstalkc/beanstalkc-0.3.0.ebuild,v 1.1 2012/10/09 08:57:28 patrick Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A simple beanstalkd client library"
HOMEPAGE="http://github.com/earl/beanstalkc http://pypi.python.org/pypi/beanstalkc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pyyaml"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="beanstalkc.py"
