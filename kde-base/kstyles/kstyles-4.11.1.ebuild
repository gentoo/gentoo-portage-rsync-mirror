# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstyles/kstyles-4.11.1.ebuild,v 1.1 2013/09/03 19:04:52 creffett Exp $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE: A set of different KDE styles."
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep liboxygenstyle)
	x11-libs/libX11
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/oxygen
"
