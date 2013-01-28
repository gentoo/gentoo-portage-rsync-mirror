# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/bamtools/bamtools-2.2.3.ebuild,v 1.1 2013/01/28 08:35:06 jlec Exp $

EAPI=4

inherit cmake-utils

DESCRIPTION="A programmer's API and an end-user's toolkit for handling BAM files"
HOMEPAGE="https://github.com/pezmaster31/bamtools"
SRC_URI="https://github.com/pezmaster31/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

DEPEND="
	dev-libs/jsoncpp
	sys-libs/zlib"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}"/${P}-unbundle.patch )

src_install() {
	cmake-utils_src_install
	use static-libs || rm "${ED}"/usr/$(get_libdir)/*.a
}
