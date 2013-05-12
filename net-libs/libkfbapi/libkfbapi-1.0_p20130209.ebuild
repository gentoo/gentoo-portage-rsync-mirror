# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkfbapi/libkfbapi-1.0_p20130209.ebuild,v 1.1 2013/05/12 16:43:23 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Library for accessing Facebook services based on KDE technology"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"
HOMEPAGE="https://projects.kde.org/projects/extragear/libs/libkfbapi"

LICENSE="|| ( LGPL-2 LGPL-3 )"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	dev-libs/libxslt
	dev-libs/qjson
"
RDEPEND="${DEPEND}"
