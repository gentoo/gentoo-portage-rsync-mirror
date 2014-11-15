# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/stem/stem-1.2.2_p20140718.ebuild,v 1.5 2014/11/15 19:26:54 blueness Exp $

EAPI=5
PYTHON_COMPAT=(python2_7)

inherit vcs-snapshot distutils-r1

DESCRIPTION="Stem is a Python controller library for Tor"
HOMEPAGE="https://stem.torproject.org"
COMMIT_ID="14861679a24e0cfb5949da8fd90f3a3c45016dfb"
SRC_URI="https://gitweb.torproject.org/stem.git/snapshot/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="test"

DEPEND="test? ( dev-python/mock[${PYTHON_USEDEP}] )
	dev-python/setuptools[${PYTHON_USEDEP}]"

RDEPEND="net-misc/tor"

DOCS=( docs/{_static,_templates,api,tutorials,{change_log,api,contents,download,faq,index,tutorials}.rst} )

python_prepare_all() {
	sed -i -e "/test_expand_path/a \
	\ \ \ \ return" test/integ/util/system.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	${PYTHON} run_tests.py --all --target RUN_ALL || die
}
