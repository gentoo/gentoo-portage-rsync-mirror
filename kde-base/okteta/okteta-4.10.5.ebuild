# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okteta/okteta-4.10.5.ebuild,v 1.6 2013/08/02 14:29:17 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdesdk"
fi
inherit ${eclass}

DESCRIPTION="KDE hexeditor"
HOMEPAGE="http://kde.org/applications/utilities/okteta
http://utils.kde.org/projects/okteta"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"

# bug #264917, removes failing test
PATCHES=( "${FILESDIR}/${PN}-4.8.2-test.patch" )
