# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-fallback/gnome-fallback-3.6.2.ebuild,v 1.4 2013/01/06 09:36:23 ago Exp $

EAPI="5"

DESCRIPTION="Sub-meta package for GNOME 3 fallback mode"
HOMEPAGE="http://www.gnome.org/"
LICENSE="metapackage"
SLOT="3.0"
IUSE="cups"

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# Note to developers:
# This is a wrapper for the GNOME 3 fallback apps list
RDEPEND="
	>=gnome-base/gnome-core-libs-${PV}[cups?]

	>=x11-wm/metacity-2.34.13
	>=x11-misc/notification-daemon-0.7.6
	>=gnome-extra/polkit-gnome-0.105
	>=gnome-base/gnome-panel-${PV}
"
DEPEND=""

S="${WORKDIR}"
