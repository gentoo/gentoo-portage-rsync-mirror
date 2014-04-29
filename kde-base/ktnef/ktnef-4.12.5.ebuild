# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktnef/ktnef-4.12.5.ebuild,v 1.1 2014/04/29 18:34:48 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A viewer for TNEF attachments."
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="LGPL-2.1"
IUSE="debug"

DEPEND="
	>=app-office/akonadi-server-1.10.45[soprano(+)]
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	akonadi/
"
