# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kwebkitpart/kwebkitpart-1.3.1.ebuild,v 1.2 2012/12/23 11:34:22 maekke Exp $

EAPI=4

WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="A WebKit KPart for konqueror"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/kwebkitpart"
SRC_URI="http://dev.gentoo.org/~johu/distfiles/${P}.tar.xz"

LICENSE="LGPL-2"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
SLOT="4"
IUSE="debug"
