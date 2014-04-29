# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blogilo/blogilo-4.12.5.ebuild,v 1.1 2014/04/29 18:34:42 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE Blogging Client"
HOMEPAGE="http://www.kde.org/applications/internet/blogilo"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	dev-libs/grantlee
	$(add_kdebase_dep kdepim-common-libs)
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	composereditor-ng/
	pimcommon/
"
