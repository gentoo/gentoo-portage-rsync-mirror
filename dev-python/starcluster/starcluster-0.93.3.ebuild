# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/starcluster/starcluster-0.93.3.ebuild,v 1.7 2014/08/28 11:16:05 mgorny Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils bash-completion-r1 eutils
MY_PN=StarCluster
MY_P=${MY_PN}-${PV}

DESCRIPTION="Utility for creating / managing general purpose computing clusters"
HOMEPAGE="http://web.mit.edu/star/cluster"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="doc epydoc"

RDEPEND=">=dev-python/ssh-1.7.13
	>=dev-python/boto-2.3.0
	>=dev-python/jinja-2.6-r1
	>=dev-python/decorator-3.1.1
	>=dev-python/pyasn1-0.0.13_beta
	=dev-python/workerpool-0.9.2"

DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx
	dev-python/epydoc
	dev-python/matplotlib )
	dev-python/setuptools"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-requires.patch
}

src_compile() {
	distutils_src_compile
	use doc && emake -C docs/sphinx html

	mkdocs() {
		local exit_status=0
		local msg="build with epydoc failed"
		pushd docs/epydoc/
		PATH=$PATH:./ PYTHONPATH="${S}/build-${PYTHON_ABI}/lib" ./build.sh || exit_status=1
		[[ $exit_status != 0 ]] && eerror "$msg"
		popd sets
		return $exit_status
	}
	use epydoc && python_execute_function -f mkdocs
}

src_install() {
	distutils_src_install

	dobashcomp completion/${PN}-completion.sh ${PN}

	use doc && dohtml -r docs/sphinx/_build/html/
	if use epydoc; then
		docompress -x usr/share/doc/${P}/apidocs/api-objects.txt
		insinto usr/share/doc/${P}/
		doins -r docs/apidocs/
	fi
}

src_test() {
	distutils_src_test -v ${PN}/tests
}
