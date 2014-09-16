# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-apps/plasma-apps-4.14.1.ebuild,v 1.1 2014/09/16 18:17:29 johu Exp $

EAPI=5

KMNAME="kde-baseapps"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Additional Applets for Plasma"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkonq)
"
RDEPEND="${DEPEND}"
