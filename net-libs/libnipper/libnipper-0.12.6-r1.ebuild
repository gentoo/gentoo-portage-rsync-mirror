# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnipper/libnipper-0.12.6-r1.ebuild,v 1.2 2011/03/19 20:08:13 scarabeus Exp $

EAPI=4

inherit base cmake-utils

DESCRIPTION="A router configuration security analysis library"
HOMEPAGE="http://nipper.titania.co.uk/"
SRC_URI="mirror://sourceforge/nipper/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

PATCHES=(
	"${FILESDIR}/${P}-glibc-2.10.patch"
)
