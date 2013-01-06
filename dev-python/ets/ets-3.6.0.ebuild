# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ets/ets-3.6.0.ebuild,v 1.1 2011/02/01 02:59:28 arfrever Exp $

EAPI="3"

DESCRIPTION="Meta package for the Enthought Tool Suite"
HOMEPAGE="http://code.enthought.com/projects/ http://pypi.python.org/pypi/ETS"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

RDEPEND="
	>=dev-python/apptools-3.4.1[doc?,examples?]
	>=dev-python/blockcanvas-3.2.1
	>=dev-python/chaco-3.4.0[doc?,examples?]
	>=dev-python/codetools-3.2.0[doc?,examples?]
	>=dev-python/enable-3.4.0[examples?]
	>=dev-python/enthoughtbase-3.1.0[doc?,examples?]
	>=dev-python/envisagecore-3.2.0[doc?,examples?]
	>=dev-python/envisageplugins-3.2.0[examples?]
	>=dev-python/etsdevtools-3.1.1[doc?,examples?]
	>=dev-python/graphcanvas-3.0.0
	>=sci-visualization/mayavi-3.4.1:2[doc?]
	>=dev-python/scimath-3.0.7
	>=dev-python/traits-3.6.0[doc?,examples?]
	>=dev-python/traitsgui-3.6.0[doc?,examples?]"
