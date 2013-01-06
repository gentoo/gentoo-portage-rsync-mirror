# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pymongo/pymongo-2.4.1.ebuild,v 1.1 2012/12/13 10:22:17 ultrabug Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_TESTS_FAILURES_TOLERANT_ABIS="*-jython"
DISTUTILS_SRC_TEST="nosetests"
PYTHON_TESTS_RESTRICTED_ABIS="3.*"
inherit distutils

DESCRIPTION="Python driver for MongoDB"
HOMEPAGE="http://github.com/mongodb/mongo-python-driver http://pypi.python.org/pypi/pymongo"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mod_wsgi"

RDEPEND="dev-db/mongodb"
DEPEND="${RDEPEND}
	dev-python/setuptools
	doc? ( dev-python/sphinx )"

PYTHON_MODNAME="bson gridfs pymongo"

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		mkdir html
		sphinx-build doc html || die "Generation of documentation failed"
	fi
}

distutils_src_test_pre_hook() {
	mkdir -p "${T}/tests-${PYTHON_ABI}/mongo.db"
	mongod --dbpath "${T}/tests-${PYTHON_ABI}/mongo.db" --fork --logpath "${T}/tests-${PYTHON_ABI}/mongo.log"
}

src_test() {
	distutils_src_test
	killall -u "$(id -nu)" mongod
}

src_install() {
	# Maintainer note:
	# In order to work with mod_wsgi, we need to disable the C extension.
	# See [1] for more information.
	# [1] http://api.mongodb.org/python/current/faq.html#does-pymongo-work-with-mod-wsgi
	distutils_src_install $(use mod_wsgi && echo --no_ext)

	if use doc; then
		dohtml -r html/* || die "Error installing docs"
	fi
}

pkg_postinst() {
	ewarn "Important changes on this release, make sure to read the changelog:"
	ewarn "http://api.mongodb.org/python/${PV}/changelog.html"
}
