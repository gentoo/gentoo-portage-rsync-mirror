# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Djblets/Djblets-0.6.22.ebuild,v 1.4 2013/06/09 16:59:24 floppym Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS=1
# pypy included below to just a single test failure
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython 2.7-pypy-*"
inherit distutils versionator

DESCRIPTION="A collection of useful extensions for Django"
HOMEPAGE="http://github.com/djblets/djblets"
SRC_URI="http://downloads.reviewboard.org/releases/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/django
	virtual/python-imaging"
DEPEND="${RDEPEND}
	test? ( dev-python/django-pipeline
		dev-python/django-evolution
		>=dev-python/django-1.4.1 )"

PYTHON_MODNAME="djblets"

src_prepare() {
	# Easier to add the file since upstream (currently) unresponsive to request
	# https://github.com/djblets/djblets/pull/6
	mkdir djblets/feedview/testdata || die
	cp "${FILESDIR}"/sample.rss djblets/feedview/testdata || die
	distutils_src_prepare
}

src_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	testing() {
		PYTHONPATH="build/lib" "$(PYTHON)" -m tests.runtests
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	local msg="Remove un-needed tests and also avoid file collisions"
	rmTests() {
		rm -rf "${ED}"/$(python_get_sitedir)/tests/ || die
	}
	einfo $msg
	einfo ""
	python_execute_function rmTests
}
