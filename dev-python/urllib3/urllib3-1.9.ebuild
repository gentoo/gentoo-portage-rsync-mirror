# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/urllib3/urllib3-1.9.ebuild,v 1.1 2014/07/16 14:16:45 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="HTTP library with thread-safe connection pooling, file post, and more"
HOMEPAGE="https://github.com/shazow/urllib3"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	$(python_gen_cond_dep \
		'dev-python/backports-ssl-match-hostname[${PYTHON_USEDEP}]' \
		'python2*' pypy)"
DEPEND="
	test? (
		>=www-servers/tornado-2.4.1[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/six[${PYTHON_USEDEP}]
	)"

python_prepare_all() {
	# Replace bundled copy of dev-python/six
	cat > urllib3/packages/six.py <<-EOF
		from __future__ import absolute_import
		from six import *
	EOF

	sed -i 's:cover-min-percentage = 100::' setup.cfg || die
	# Fix tests
	sed -i 's/urllib3.packages.six/six/' test/test_retry.py || die
	sed -i '/clear_warnings/d' test/test_util.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	nosetests -v || die "Tests fail with ${EPYTHON}"
}
