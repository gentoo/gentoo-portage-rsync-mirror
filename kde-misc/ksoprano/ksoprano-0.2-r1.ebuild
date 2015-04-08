# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksoprano/ksoprano-0.2-r1.ebuild,v 1.1 2014/05/13 17:57:00 johu Exp $

EAPI=5

KDE_MINIMAL="4.13.1"
inherit kde4-base

DESCRIPTION="A GUI for querying and manipulating RDF data"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=116756"
SRC_URI="http://kde-apps.org/CONTENT/content-files/116756-${PN}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdelibs 'nepomuk')
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep nepomuk)
"

S="${WORKDIR}/${PN}"
