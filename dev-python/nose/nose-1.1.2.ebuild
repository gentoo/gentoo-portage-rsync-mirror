# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nose/nose-1.1.2.ebuild,v 1.10 2012/05/09 00:06:38 aballier Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils

DESCRIPTION="A unittest extension offering automatic test suite discovery and easy test authoring"
HOMEPAGE="http://pypi.python.org/pypi/nose http://readthedocs.org/docs/nose/ https://bitbucket.org/jpellerin/nose"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="coverage doc examples test"

RDEPEND="coverage? ( dev-python/coverage )
	dev-python/setuptools"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )
	test? ( dev-python/twisted )"

DOCS="AUTHORS"

src_prepare() {
	distutils_src_prepare
	# Disable sphinx.ext.intersphinx, requires network
	epatch "${FILESDIR}/${PN}-0.11.0-disable_intersphinx.patch"
	# Disable tests requiring network connection.
	sed \
		-e "s/test_resolve/_&/g" \
		-e "s/test_raises_bad_return/_&/g" \
		-e "s/test_raises_twisted_error/_&/g" \
		-i unit_tests/test_twisted.py || die "sed failed"
	# Disable versioning of nosetests script to avoid collision with versioning performed by distutils_src_install().
	sed -e "/'nosetests%s = nose:run_exit' % py_vers_tag,/d" -i setup.py || die "sed failed"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		einfo "Generation of documentation"
		pushd doc > /dev/null
		emake html
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		if [[ "$(python_get_version --major)" == "3" ]]; then
			rm -fr build || return 1
			"$(PYTHON)" setup.py build_tests || return 1
		fi
		"$(PYTHON)" setup.py egg_info || return 1
		"$(PYTHON)" selftest.py -v
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install --install-data "${EPREFIX}/usr/share"
	python_generate_wrapper_scripts -E -f -q "${ED}usr/bin/nosetests"
	if use doc; then
		dohtml -r -A txt doc/.build/html/* || die "Installation of documentation failed"
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
