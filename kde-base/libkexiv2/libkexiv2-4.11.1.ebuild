# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkexiv2/libkexiv2-4.11.1.ebuild,v 1.1 2013/09/03 19:04:31 creffett Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE Image Plugin Interface: an exiv2 library wrapper"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	>=media-gfx/exiv2-0.20
	virtual/jpeg:0
"
RDEPEND="${DEPEND}"
