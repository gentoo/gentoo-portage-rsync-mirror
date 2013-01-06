# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ets/ets-4.0.0-r1.ebuild,v 1.1 2011/08/05 22:18:34 bicatali Exp $

EAPI="3"

DESCRIPTION="Meta package for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/ http://pypi.python.org/pypi/ets"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	>=dev-python/apptools-${PV}[doc?,examples?]
	>=dev-python/blockcanvas-${PV}[doc?]
	>=dev-python/chaco-${PV}[doc?,examples?]
	>=dev-python/codetools-${PV}[doc?,examples?]
	>=dev-python/enable-${PV}[doc?,examples?]
	>=dev-python/envisage-${PV}[doc?,examples?]
	>=dev-python/etsdevtools-${PV}[doc?,examples?]
	>=dev-python/graphcanvas-${PV}[examples?]
	>=sci-visualization/mayavi-${PV}[examples?]
	>=dev-python/scimath-${PV}[doc?]
	>=dev-python/traits-${PV}[doc?,examples?]
	>=dev-python/traitsui-${PV}[doc?,examples?]"
