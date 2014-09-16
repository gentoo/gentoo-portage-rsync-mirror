# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/blogilo/blogilo-4.14.1.ebuild,v 1.1 2014/09/16 18:17:23 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="KDE Blogging Client"
HOMEPAGE="http://www.kde.org/applications/internet/blogilo"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepim-common-libs)
	$(add_kdebase_dep kdepimlibs)
	>=net-libs/libkgapi-2.2.0
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	composereditor-ng/
	pimcommon/
"
