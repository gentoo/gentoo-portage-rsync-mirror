# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-4.10.2.ebuild,v 1.5 2013/05/05 10:13:53 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdesdk"
fi
inherit ${eclass}

DESCRIPTION="KDE UML Modeller"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
"
DEPEND="${RDEPEND}
	dev-libs/boost
"
