# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pytextile/pytextile-2.1.5.ebuild,v 1.6 2012/04/09 03:41:03 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

MY_PN="textile"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A Python implementation of Textile, Dean Allen's Human Text Generator for creating (X)HTML."
HOMEPAGE="http://pypi.python.org/pypi/textile"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${MY_PN}"
