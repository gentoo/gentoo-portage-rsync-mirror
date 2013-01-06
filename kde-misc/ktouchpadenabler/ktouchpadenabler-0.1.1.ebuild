# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ktouchpadenabler/ktouchpadenabler-0.1.1.ebuild,v 1.1 2012/10/13 21:04:10 johu Exp $

EAPI=4

KDE_LINGUAS="ar ca cs da de el es et fi fr ga hu ja kk km lt nb nds nl pl pt
pt_BR sk sl sv uk zh_CN zh_TW"
inherit kde4-base

DESCRIPTION="KDED daemon listening to XF86XK_TouchpadToggle"
HOMEPAGE="http://projects.kde.org/projects/extragear/base/ktouchpadenabler"
SRC_URI="mirror://kde/stable/extragear/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="x11-libs/libXi"
RDEPEND="${DEPEND}"
