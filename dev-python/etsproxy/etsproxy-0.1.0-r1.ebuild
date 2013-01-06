# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/etsproxy/etsproxy-0.1.0-r1.ebuild,v 1.1 2011/08/05 22:26:33 bicatali Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Enthought Tool Suite: proxy modules for backwards compatibility"
HOMEPAGE="http://pypi.python.org/pypi/etsproxy"
SRC_URI="http://www.enthought.com/repo/ets/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="!<dev-python/apptools-4
	!<dev-python/blockcanvas-4
	!<dev-python/chaco-4
	!<dev-python/codetools-4
	!<dev-python/enable-4
	!<dev-python/enthoughtbase-4
	!<dev-python/envisagecore-4
	!<dev-python/envisageplugins-4
	!<dev-python/etsdevtools-4
	!<dev-python/etsprojecttools-4
	!<dev-python/graphcanvas-4
	!<sci-visualization/mayavi-4
	!<dev-python/scimath-4
	!<dev-python/traits-4
	!<dev-python/traitsbackendwx-4
	!<dev-python/traitsbackendqt-4
	!<dev-python/traitsgui-4"

DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_MODNAME="enthought"
