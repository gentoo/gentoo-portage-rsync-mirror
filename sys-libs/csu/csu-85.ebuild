# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/csu/csu-85.ebuild,v 1.2 2015/02/28 10:53:58 grobian Exp $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="Darwin Csu (crt1.o) - Mac OS X 10.10 version"
HOMEPAGE="http://www.opensource.apple.com/"
SRC_URI="http://www.opensource.apple.com/tarballs/Csu/Csu-${PV}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos ~x64-macos ~x86-macos"
IUSE=""
S=${WORKDIR}/Csu-${PV}

src_prepare() {
	# since we don't have crt0, we can't build it either
	sed -i \
		-e 's:$(SYMROOT)/crt0.o::' \
		-e '/LOCLIBDIR)\/crt0.o/d' \
		-e '/^CC = /d' \
		Makefile || die

	# deal with Availability.h missing
	echo "#include <Availability.h>" | $(tc-getCC) -o - -c -x c - >& /dev/null \
		|| epatch "${FILESDIR}"/${P}-darwin8.patch

	if [[ ${CHOST} == powerpc* ]] ; then
		# *must not* be compiled with -Os on PPC because that
		# will optimize out
		# _pointer_to__darwin_gcc3_preregister_frame_info which
		# causes linker errors for large programs because the
		# jump to ___darwin_gcc3_preregister_frame_info gets to
		# be more than 16MB away
		sed -i -e "s, -Os , -O ,g" Makefile || die
	fi
}

src_compile() {
	emake USRLIBDIR="${EPREFIX}"/lib || die
}

src_install() {
	emake -j1 \
		USRLIBDIR="${EPREFIX}"/lib \
		LOCLIBDIR="${EPREFIX}"/lib \
		DSTROOT="${D}" \
		install || die
}
