# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/libkfbapi/libkfbapi-1.0_p20130209.ebuild,v 1.1 2013/02/11 03:39:05 creffett Exp $

EAPI=5

inherit kde4-base
DESCRIPTION="A library for accessing Facebook services"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libkfbapi"

LICENSE="|| ( LGPL-2 LGPL-3 )"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	dev-libs/libxslt
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
