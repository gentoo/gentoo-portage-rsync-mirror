# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-applets-python/gnome-applets-python-2.32.0-r1.ebuild,v 1.1 2014/05/26 18:05:06 mgorny Exp $

EAPI="5"

GNOME_ORG_MODULE="gnome-python-desktop"
G_PY_BINDINGS="applet"
PYTHON_COMPAT=( python2_7 )

inherit gnome-python-common-r1

DESCRIPTION="Python bindings for writing GNOME applets"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=gnome-base/gnome-panel-2.13.4
	>=dev-python/libbonobo-python-2.22.0:2[${PYTHON_USEDEP}]
	gnome-base/libgnome
	gnome-base/libgnomeui
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"

EXAMPLES=( examples/applet/. )
