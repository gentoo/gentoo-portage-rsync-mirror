# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kigo/kigo-4.9.5.ebuild,v 1.5 2013/02/23 16:35:55 ago Exp $

EAPI=4

if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdegames"
fi
KDE_HANDBOOK="optional"
inherit ${eclass}

DESCRIPTION="KDE Go game"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	games-board/gnugo
"
