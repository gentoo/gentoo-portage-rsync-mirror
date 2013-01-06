# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-themes/flask-themes-0.1.3.ebuild,v 1.1 2011/09/08 07:20:02 rafaelmartins Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="Flask-Themes"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Infrastructure for theming support in Flask applications."
HOMEPAGE="http://packages.python.org/Flask-Themes/ http://pypi.python.org/pypi/Flask-Themes"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/flask-0.6
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 dev-python/simplejson )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="flaskext/themes.py"
