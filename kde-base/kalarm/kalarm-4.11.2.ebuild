# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-4.11.2.ebuild,v 1.2 2013/12/08 14:07:18 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
HOMEPAGE+=" http://userbase.kde.org/KAlarm"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
	media-libs/phonon
	x11-libs/libX11
"
DEPEND="${RDEPEND}"

KMEXTRACTONLY="
	kmail/
"
