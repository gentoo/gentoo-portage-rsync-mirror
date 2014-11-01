# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kwebkitpart/kwebkitpart-1.3.4.ebuild,v 1.4 2014/11/01 17:49:25 ago Exp $

EAPI=5

WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="A WebKit KPart for Konqueror"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/kwebkitpart"
SRC_URI="http://dev.gentoo.org/~kensington/distfiles/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="4"
KEYWORDS="amd64 ~arm ppc ppc64 ~x86"
IUSE="debug"
