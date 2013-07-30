# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork-filesharing/kdenetwork-filesharing-4.10.5.ebuild,v 1.4 2013/07/30 10:41:20 ago Exp $

EAPI=5

if [[ $PV != *9999 ]]; then
	KMNAME="kdenetwork"
	KDE_ECLASS=meta
else
	KDE_ECLASS=base
fi

inherit kde4-${KDE_ECLASS}

DESCRIPTION="kcontrol filesharing config module for SMB"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
