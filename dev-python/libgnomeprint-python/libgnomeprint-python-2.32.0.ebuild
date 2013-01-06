# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgnomeprint-python/libgnomeprint-python-2.32.0.ebuild,v 1.8 2011/03/22 19:00:20 ranger Exp $

EAPI="3"
GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="gnomeprint gnomeprintui"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome-python-common

DESCRIPTION="Python bindings for GNOME printing support"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc examples"

RDEPEND=">=gnome-base/libgnomeprint-2.2.0:2.2
	>=gnome-base/libgnomeprintui-2.2.0:2.2
	>=dev-python/libgnomecanvas-python-2.25.90:2
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gnomeprint/*"
