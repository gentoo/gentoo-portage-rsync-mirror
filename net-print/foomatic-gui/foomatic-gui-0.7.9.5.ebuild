# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-gui/foomatic-gui-0.7.9.5.ebuild,v 1.2 2012/01/28 21:37:54 dilfridge Exp $

EAPI="3"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="GNOME interface for configuring the Foomatic printer filter system"
HOMEPAGE="http://freshmeat.net/projects/foomatic-gui/"
SRC_URI="mirror://debian/pool/main/f/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="
	dev-python/libgnome-python
	dev-python/pygobject:2
	dev-python/libbonobo-python
	dev-python/gnome-vfs-python
	dev-python/ipy
	dev-python/pygtk:2
	dev-python/pywebkitgtk
	net-print/foomatic-db-engine"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME="foomatic"
