# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-pipeline/django-pipeline-1.2.6.ebuild,v 1.2 2013/01/21 05:46:14 idella4 Exp $

EAPI=4
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="http://pypi.python.org/pypi/django-pipeline/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

LICENSE="MIT"
SLOT="0"
PYTHON_MODNAME="pipeline"
DISTUTILS_SRC_TEST=nosetests
RDEPEND=">=dev-python/django-1.4"
DEPEND="${RDEPEND}
	dev-python/setuptools"

src_compile() {
	use doc && emake -C docs html
	rm -f docs/_build/doctrees/environment.pickle || die
	distutils_src_compile
}

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	# Python.[56] trigger a harmless deprecation warning
	testing() {
		local exit_status=0 test
		pushd build-${PYTHON_ABI}/lib/tests/tests/ > /dev/null || die
		for test in [a-z]*.py
		do
			if ! "$(PYTHON)" ${test}; then
				eerror "test "${test}" failed"
				exit_status="1"
			else
				einfo "test "${test}" passed OK"
			fi
		done
		popd > /dev/null
		return ${exit_status}
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r docs/_build/html/
	fi

	# Remove un-needed tests to avoid file collisions
	rmtests() {
		rm -rf "${ED}"/$(python_get_sitedir)/tests/ || die
	}

	python_execute_function rmtests
}
