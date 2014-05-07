# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knotes/knotes-4.12.5.ebuild,v 1.2 2014/05/07 09:07:33 zlogene Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE Notes application"
HOMEPAGE="http://www.kde.org/applications/utilities/knotes/"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	pimcommon/
"

KMLOADLIBS="kdepim-common-libs"
