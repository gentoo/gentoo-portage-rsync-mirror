# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.10.2.ebuild,v 1.4 2013/05/01 11:50:53 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.20
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
