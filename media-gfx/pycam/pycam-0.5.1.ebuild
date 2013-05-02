# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pycam/pycam-0.5.1.ebuild,v 1.1 2013/05/02 20:25:39 slis Exp $

EAPI=5

inherit distutils

DESCRIPTION="Open Source CAM - Toolpath Generation for 3-Axis CNC machining"
HOMEPAGE="http://pycam.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"

DEPEND="
	dev-python/pygtk
	dev-python/pygtkglext
	dev-python/pyopengl
"
RDEPEND="${DEPEND}"
