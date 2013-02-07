# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdcraw/libkdcraw-4.10.0.ebuild,v 1.1 2013/02/07 04:57:49 alexxy Exp $

EAPI=5

# needed for digikam
KDE_OVERRIDE_MINIMAL="4.9.0"

inherit kde4-base

DESCRIPTION="KDE digital camera raw image library wrapper"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	media-libs/lcms:0
	virtual/jpeg
"
RDEPEND="${DEPEND}"
