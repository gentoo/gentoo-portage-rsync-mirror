# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pylons/pylons-1.0.1.ebuild,v 1.2 2012/11/07 10:28:17 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Pylons"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Pylons Web Framework"
HOMEPAGE="http://pylonshq.com/ http://pypi.python.org/pypi/Pylons"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="genshi jinja test"

RDEPEND=">=dev-python/beaker-1.3
	>=dev-python/decorator-2.3.2
	>=dev-python/formencode-1.2.1
	>=dev-python/mako-0.2.4
	>=dev-python/nose-0.10.4
	>=dev-python/paste-1.7.2
	>=dev-python/pastedeploy-1.3.3
	>=dev-python/pastescript-1.7.3
	>=dev-python/repoze-lru-0.3
	>=dev-python/routes-1.12
	>=dev-python/simplejson-2.0.8
	>=dev-python/tempita-0.2
	>=dev-python/weberror-0.10.1
	>=dev-python/webhelpers-0.6.4
	>=dev-python/webob-0.9.6.1
	>=dev-python/webtest-1.1
	genshi? ( >=dev-python/genshi-0.4.4 )
	jinja? ( >=dev-python/jinja-2 )"
# Dependency on >=dev-python/coverage-2.85 and dev-python/genshi is not with Jython.
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (
		>=dev-python/coverage-2.85
		dev-python/genshi
		>=dev-python/jinja-2.2.1
	)"

S="${WORKDIR}/${MY_P}"
