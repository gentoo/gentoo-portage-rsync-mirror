# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-4.10.5.ebuild,v 1.2 2013/07/27 11:45:28 ago Exp $

EAPI=5

if [[ $PV != *9999 ]]; then
	KMNAME="kdenetwork"
	KDE_ECLASS=meta
else
	KDE_ECLASS=base
fi

KDE_HANDBOOK="optional"
inherit kde4-${KDE_ECLASS}

DESCRIPTION="KDE: A dialer and front-end to pppd."
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	net-dialup/ppp
"
