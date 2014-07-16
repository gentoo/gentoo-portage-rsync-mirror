# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-4.13.3.ebuild,v 1.1 2014/07/16 17:40:10 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kde-baseapps"
inherit kde4-meta

DESCRIPTION="KDE GUI for passwd"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep kdesu)
"
