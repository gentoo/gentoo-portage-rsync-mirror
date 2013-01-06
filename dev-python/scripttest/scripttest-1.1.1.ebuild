# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scripttest/scripttest-1.1.1.ebuild,v 1.1 2011/09/03 18:10:45 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="ScriptTest"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A very small text templating language"
HOMEPAGE="http://pythonpaste.org/scripttest/ http://pypi.python.org/pypi/ScriptTest"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
