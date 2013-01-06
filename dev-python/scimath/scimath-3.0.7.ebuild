# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/scimath/scimath-3.0.7.ebuild,v 1.2 2012/02/24 09:40:50 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils

MY_PN="SciMath"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Enthought Tool Suite: Scientific and mathematical tools"
HOMEPAGE="http://code.enthought.com/projects/sci_math/ http://pypi.python.org/pypi/SciMath"
SRC_URI="http://www.enthought.com/repo/ETS/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-python/enthoughtbase-3.1.0
	>=dev-python/numpy-1.1
	>=dev-python/traits-3.6.0
	>=dev-python/traitsgui-3.6.0[wxwidgets]
	sci-libs/scipy"
DEPEND="${RDEPEND}
	dev-python/setuptools
	test? (
		>=dev-python/etsdevtools-3.1.1
		dev-python/nose
	)"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="enthought"
