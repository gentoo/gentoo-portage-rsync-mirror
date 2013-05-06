# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdepasswd/kdepasswd-4.10.3.ebuild,v 1.1 2013/05/06 20:17:55 johu Exp $

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

KMLOADLIBS="libkonq"
