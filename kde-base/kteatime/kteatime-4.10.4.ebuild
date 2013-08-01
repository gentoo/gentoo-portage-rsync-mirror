# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kteatime/kteatime-4.10.4.ebuild,v 1.6 2013/08/01 17:32:28 johu Exp $

EAPI=5

if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdetoys"
fi
KDE_HANDBOOK="optional"
inherit ${eclass}

DESCRIPTION="KDE timer for making a fine cup of tea"
HOMEPAGE="http://www.kde.org/applications/games/kteatime"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
