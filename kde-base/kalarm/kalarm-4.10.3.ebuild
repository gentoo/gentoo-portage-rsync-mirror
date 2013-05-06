# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kalarm/kalarm-4.10.3.ebuild,v 1.1 2013/05/06 20:18:49 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="Personal alarm message, command and email scheduler for KDE"
KEYWORDS=" ~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	$(add_kdebase_dep kdepim-common-libs)
	media-libs/phonon
"
DEPEND="${RDEPEND}"

KMEXTRACTONLY="
	kmail/
"
