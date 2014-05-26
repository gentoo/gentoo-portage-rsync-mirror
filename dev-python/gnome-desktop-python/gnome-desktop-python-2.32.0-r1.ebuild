# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gnome-desktop-python/gnome-desktop-python-2.32.0-r1.ebuild,v 1.1 2014/05/26 18:05:04 mgorny Exp $

EAPI="5"

GNOME_ORG_MODULE="gnome-python-desktop"
G_PY_BINDINGS="gnomedesktop"
PYTHON_COMPAT=( python2_7 )

inherit gnome-python-common-r1

DESCRIPTION="Python bindings for some GNOME desktop libraries"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-base/gnome-desktop-2.10.0:2
	>=dev-python/gnome-vfs-python-2.22:2[${PYTHON_USEDEP}]
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
