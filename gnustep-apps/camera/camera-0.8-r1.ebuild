# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/camera/camera-0.8-r1.ebuild,v 1.4 2008/03/08 13:58:52 coldwind Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/c/C}

DESCRIPTION="A simple tool to download photos from a digital camera."
HOMEPAGE="http://home.gna.org/gsimageapps/"
SRC_URI="http://download.gna.org/gsimageapps/${P/c/C}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND="gnustep-libs/camerakit"
RDEPEND="${DEPEND}"
