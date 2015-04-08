# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/taglib-extras/taglib-extras-1.0.1-r1.ebuild,v 1.1 2015/04/02 15:46:31 kensington Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Unofficial taglib plugins maintained by the Amarok team"
HOMEPAGE="http://developer.kde.org/~wheeler/taglib.html"
SRC_URI="http://dev.gentoo.org/~kensington/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	>=media-libs/taglib-1.6
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog )
