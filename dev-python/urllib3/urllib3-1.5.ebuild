# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urllib3/urllib3-1.5.ebuild,v 1.3 2012/10/06 02:00:49 blueness Exp $

EAPI=4

PYTHON_DEPEND="*:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5"
DISTUTILS_SRC_TEST="nosetests"
PYTHON_TESTS_RESTRICTED_ABIS="2.6 3.1"

inherit distutils

DESCRIPTION="HTTP library with thread-safe connection pooling, file post, and more"
HOMEPAGE="https://github.com/shazow/urllib3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RDEPEND="dev-python/six"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? ( www-servers/tornado )"

src_prepare() {
	# Replace bundled copy of dev-python/six
	cat > urllib3/packages/six.py <<-EOF
	from __future__ import absolute_import
	from six import *
	EOF

	sed -i -e "s/'dummyserver',//" setup.py || die

	distutils_src_prepare
}
