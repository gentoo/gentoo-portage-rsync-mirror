# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-gtkmvc/python-gtkmvc-1.2.2.ebuild,v 1.4 2012/01/14 16:46:57 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="model-view-controller (MVC) implementation for pygtk"
HOMEPAGE="http://pygtkmvc.sourceforge.net/"
SRC_URI="mirror://sourceforge/pygtkmvc/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-python/pygtk-2.4.0"
RESTRICT_PYTHON_ABIS="3.*"

PYTHON_MODNAME="gtkmvc"
