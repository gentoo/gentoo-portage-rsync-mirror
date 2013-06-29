# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kolor-manager/kolor-manager-1.0.1.ebuild,v 1.2 2013/06/29 12:14:41 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KControl module for Oyranos CMS cross desktop settings."
HOMEPAGE="http://www.oyranos.org/wiki/index.php?title=Kolor-manager"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.xz"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="
	>=media-libs/oyranos-0.9.3
	media-libs/libXcm
	x11-libs/libXrandr
"
RDEPEND="${DEPEND}"
