# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/soxr/soxr-0.1.1.ebuild,v 1.2 2013/04/15 19:56:14 nativemad Exp $

EAPI=5

inherit cmake-multilib

MY_P=${P}-Source
DESCRIPTION="The SoX Resampler library"
HOMEPAGE="https://sourceforge.net/p/soxr/wiki/Home/"
SRC_URI="mirror://sourceforge/soxr/${MY_P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86"
IUSE="examples"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
DOCS=( "README" "TODO" "NEWS" "AUTHORS" )
PATCHES=(
	"${FILESDIR}/nodoc.patch"
	"${FILESDIR}/noexamples.patch"
	)

src_install() {
	cmake-multilib_src_install
	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
