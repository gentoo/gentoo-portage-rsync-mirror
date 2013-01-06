# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/polkit-kde-kcmodules/polkit-kde-kcmodules-0.98_pre20120917.ebuild,v 1.4 2012/11/16 12:56:22 blueness Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="PolKit agent module for KDE."
HOMEPAGE="http://www.kde.org"
SRC_URI="http://dev.gentoo.org/~johu/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=sys-auth/polkit-kde-agent-0.99
	>=sys-auth/polkit-qt-0.103
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"
