# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blogilo/blogilo-4.11.2.ebuild,v 1.2 2013/12/08 14:07:33 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE Blogging Client"
HOMEPAGE="http://www.kde.org/applications/internet/blogilo"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	dev-libs/grantlee
	$(add_kdebase_dep kdepim-common-libs)
	$(add_kdebase_dep kdepimlibs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	composereditor-ng
"
