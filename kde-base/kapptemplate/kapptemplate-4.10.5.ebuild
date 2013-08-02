# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kapptemplate/kapptemplate-4.10.5.ebuild,v 1.6 2013/08/02 14:30:02 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdesdk"
fi
inherit ${eclass}

DESCRIPTION="KAppTemplate - A shell script to create the necessary framework to develop KDE applications."
HOMEPAGE="http://www.kde.org/applications/development/kapptemplate"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
