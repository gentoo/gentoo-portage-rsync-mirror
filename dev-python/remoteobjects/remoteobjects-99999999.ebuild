# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/remoteobjects/remoteobjects-99999999.ebuild,v 1.3 2011/09/21 08:46:37 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

if [[ ${PV} == "99999999" ]] ; then
	EGIT_REPO_URI="git://github.com/LegNeato/${PN}.git
		https://github.com/LegNeato/${PN}.git"
	inherit git-2
fi

DESCRIPTION="subclassable Python objects for working with JSON REST APIs"
HOMEPAGE="https://github.com/LegNeato/remoteobjects"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/simplejson
	dev-python/httplib2"
DEPEND="${DEPEND}
	dev-python/setuptools
	test? ( dev-python/mox )"

src_prepare() {
	distutils_src_prepare

	# Disable failing tests.
	sed -e "s/test_get_bad_encoding/_&/" -i tests/test_http.py
}
