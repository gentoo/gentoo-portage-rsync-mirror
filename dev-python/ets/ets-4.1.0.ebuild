# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ets/ets-4.1.0.ebuild,v 1.1 2012/01/17 06:22:22 bicatali Exp $

EAPI=4

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Meta package for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/ http://pypi.python.org/pypi/ets"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

# see the setup_data.py file for version numbers
RDEPEND="
	>=dev-python/apptools-4.0.1[doc?,examples?]
	>=dev-python/blockcanvas-4.0.1[doc?]
	>=dev-python/chaco-4.1.0[doc?,examples?]
	>=dev-python/codetools-4.0.0[doc?,examples?]
	>=dev-python/enable-4.1.0[doc?,examples?]
	>=dev-python/envisage-4.1.0[doc?,examples?]
	>=dev-python/etsdevtools-4.0.0[doc?,examples?]
	>=dev-python/graphcanvas-4.0.0[examples?]
	>=sci-visualization/mayavi-4.1.0[doc?,examples?]
	>=dev-python/pyface-4.1.0[doc?,examples?]
	>=dev-python/scimath-4.0.1[doc?]
	>=dev-python/traits-4.1.0[doc?,examples?]
	>=dev-python/traitsui-4.1.0[doc?,examples?]"

DEPEND=""
