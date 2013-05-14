# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ets/ets-4.3.0-r1.ebuild,v 1.1 2013/05/14 19:22:59 idella4 Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Meta package for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/ http://pypi.python.org/pypi/ets"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc examples"

# see the setup_data.py file for version numbers
RDEPEND="
	>=dev-python/apptools-4.2.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/blockcanvas-4.0.3[doc?,${PYTHON_USEDEP}]
	>=dev-python/casuarius-1.1[${PYTHON_USEDEP}]
	>=dev-python/chaco-4.3.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/codetools-4.1.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/enable-4.3.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/enaml-0.6.8[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/encore-0.3[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/envisage-4.3.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/etsdevtools-4.0.2[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/etsproxy-0.1.2
	>=dev-python/graphcanvas-4.0.2[examples?,${PYTHON_USEDEP}]
	>=sci-visualization/mayavi-4.3.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/pyface-4.3.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/scimath-4.1.2[doc?,${PYTHON_USEDEP}]
	>=dev-python/traits-4.3.0[doc?,examples?,${PYTHON_USEDEP}]
	>=dev-python/traitsui-4.3.0[doc?,examples?,${PYTHON_USEDEP}]"

DEPEND=""
