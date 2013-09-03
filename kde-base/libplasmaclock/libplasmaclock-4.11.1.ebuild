# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libplasmaclock/libplasmaclock-4.11.1.ebuild,v 1.1 2013/09/03 19:04:50 creffett Exp $

EAPI=5

KMNAME="kde-workspace"
KMMODULE="libs/plasmaclock"
inherit kde4-meta

DESCRIPTION="Libraries for KDE Plasma's clocks"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kephal)
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"

KMEXTRACTONLY="
	libs/kephal/
"
