# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kookie/kookie-0.1.1.ebuild,v 1.2 2011/10/29 00:35:18 abcd Exp $

EAPI=4
inherit kde4-base

DESCRIPTION="Program to manage recipes and shopping lists"
HOMEPAGE="http://www.kde-apps.org/content/show.php/Kookie?content=117806"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"
