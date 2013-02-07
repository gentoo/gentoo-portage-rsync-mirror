# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/prison/prison-1.0.ebuild,v 1.8 2013/02/07 01:02:39 naota Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="QRCode and data matrix barcode library"
HOMEPAGE="https://projects.kde.org/projects/kdesupport/prison"
SRC_URI="mirror://kde/stable/${PN}/${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~arm ppc x86 ~x86-fbsd"
SLOT="4"
IUSE="debug"

DEPEND="
	media-gfx/qrencode
	media-libs/libdmtx
"
RDEPEND="${DEPEND}"
