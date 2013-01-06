# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcompmgr/xcompmgr-1.1.6.ebuild,v 1.7 2012/08/26 19:29:11 armin76 Exp $

EAPI=4

XORG_STATIC=no
inherit xorg-2

DESCRIPTION="X Compositing manager"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="http://xorg.freedesktop.org/releases/individual/app/${P}.tar.bz2"

LICENSE="BSD"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="x11-libs/libXrender
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXcomposite"
DEPEND="${RDEPEND}"
