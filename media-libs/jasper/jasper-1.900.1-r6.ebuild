# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/jasper/jasper-1.900.1-r6.ebuild,v 1.1 2013/03/17 16:41:58 jlec Exp $

EAPI=5

inherit autotools-multilib

DESCRIPTION="software-based implementation of the codec specified in the JPEG-2000 Part-1 standard"
HOMEPAGE="http://www.ece.uvic.ca/~mdadams/jasper/"
SRC_URI="
	http://www.ece.uvic.ca/~mdadams/jasper/software/jasper-${PV}.zip
	mirror://gentoo/${P}-fixes-20120611.patch.bz2"

LICENSE="JasPer2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE="jpeg opengl static-libs"

RDEPEND="
	jpeg? (
		virtual/jpeg
		amd64? (
			abi_x86_32? ( app-emulation/emul-linux-x86-baselibs )
			)
		)
	opengl? (
		virtual/opengl media-libs/freeglut
		amd64? (
			abi_x86_32? ( app-emulation/emul-linux-x86-opengl )
			)
		)"
DEPEND="${RDEPEND}
	app-arch/unzip"

PATCHES=( "${WORKDIR}/${P}-fixes-20120611.patch" )

DOCS=( NEWS README doc/. )

src_configure() {
	local myeconfargs=(
		$(use_enable jpeg libjpeg)
		$(use_enable opengl)
		)
	autotools-multilib_src_configure
}
