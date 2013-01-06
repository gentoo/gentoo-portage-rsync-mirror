# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-virtkey/python-virtkey-0.60.0.ebuild,v 1.4 2012/05/04 15:12:16 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils versionator

DESCRIPTION="Python module to simulate keypresses and get current keyboard layout"
HOMEPAGE="https://launchpad.net/virtkey"
SRC_URI="http://launchpad.net/python-virtkey/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
