# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kephal/kephal-4.9.5.ebuild,v 1.4 2013/01/27 23:27:47 ago Exp $

EAPI=4

KMNAME="kde-workspace"
KMMODULE="libs/kephal"
inherit kde4-meta

DESCRIPTION="Allows handling of multihead systems via the XRandR extension"
KEYWORDS="amd64 ~arm ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-libs/libxkbfile
	x11-libs/libXrandr
"
DEPEND="${RDEPEND}
	x11-proto/randrproto
"
