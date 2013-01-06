# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-memcached/python-memcached-1.47.ebuild,v 1.4 2011/02/27 18:25:53 ranger Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Pure python memcached client"
HOMEPAGE="http://www.tummy.com/Community/software/python-memcached/ http://pypi.python.org/pypi/python-memcached"
SRC_URI="ftp://ftp.tummy.com/pub/python-memcached/old-releases/${P}.tar.gz"

LICENSE="OSL-2.0"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

PYTHON_MODNAME="memcache.py"
