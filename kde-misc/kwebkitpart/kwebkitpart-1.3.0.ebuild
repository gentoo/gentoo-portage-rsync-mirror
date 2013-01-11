# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kwebkitpart/kwebkitpart-1.3.0.ebuild,v 1.6 2013/01/11 13:02:44 ago Exp $

EAPI=4

WEBKIT_REQUIRED="always"
inherit kde4-base

DESCRIPTION="A WebKit KPart for konqueror"
HOMEPAGE="https://projects.kde.org/projects/extragear/base/kwebkitpart"
SRC_URI="http://dev.gentoo.org/~johu/distfiles/${P}.tar.xz"

LICENSE="LGPL-2"
KEYWORDS="amd64 ppc x86"
SLOT="4"
IUSE="debug"
