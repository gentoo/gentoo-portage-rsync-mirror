# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-memcached/python-memcached-1.48.ebuild,v 1.1 2012/01/08 07:00:30 patrick Exp $

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
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="test"

DEPEND="dev-python/setuptools
	test? ( net-misc/memcached )"
RDEPEND=""

PYTHON_MODNAME="memcache.py"

src_test() {
	cp memcache.py memcache_test.py || die
	sed -ie "s/11211/11219/" memcache_test.py || die
	testing() {
		memcached -u portage -d -p 11219 -l localhost -P "${T}/memcached.pid"
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" memcache_test.py || die
		kill "$(<"${T}/memcached.pid")"
		rm "${T}/memcached.pid"
	}
	python_execute_function testing
}
