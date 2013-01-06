# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/akonadi-facebook/akonadi-facebook-0_p20120222.ebuild,v 1.1 2012/02/22 16:43:28 johu Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Facebook services integration in Akonadi"
HOMEPAGE="https://projects.kde.org/akonadi-facebook"
SRC_URI="http://dev.gentoo.org/~johu/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs semantic-desktop)
	dev-libs/boost
	dev-libs/libxslt
	dev-libs/qjson
"
RDEPEND="${DEPEND}"

S=${WORKDIR}
