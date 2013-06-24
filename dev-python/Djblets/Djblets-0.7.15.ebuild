# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/Djblets/Djblets-0.7.15.ebuild,v 1.2 2013/06/24 15:21:20 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1 versionator

DESCRIPTION="A collection of useful extensions for Django"
HOMEPAGE="http://github.com/djblets/djblets"
SRC_URI="http://downloads.reviewboard.org/releases/${PN}/$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/django-1.4.5[${PYTHON_USEDEP}]
	<dev-python/django-1.5[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]
	>=dev-python/django-pipeline-1.2.24[${PYTHON_USEDEP}]
	>=dev-python/feedparser-5.1.2[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/django-evolution[${PYTHON_USEDEP}]"
DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( ${RDEPEND} )"

python_prepare_all() {
	# Easier to add the file since upstream (currently) unresponsive to request
	# https://github.com/djblets/djblets/pull/6; & only if running tests
	if use test; then
		mkdir djblets/feedview/testdata || die
		cp "${FILESDIR}"/sample.rss djblets/feedview/testdata || die
	fi
	epatch "${FILESDIR}"/exclude-tests.patch
	distutils-r1_python_prepare_all
}

python_test() {
	export DJANGO_SETTINGS_MODULE="django.conf"
	"${PYTHON}" -m tests.runtests || die "Tests failed under ${EPYTHON}"
}
