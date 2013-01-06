# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/mpir/mpir-2.4.0.ebuild,v 1.2 2011/08/15 09:22:11 tomka Exp $

EAPI=4

inherit eutils autotools-utils

DESCRIPTION="Library for arbitrary precision integer arithmetic derived from version 4.2.1 of gmp"
HOMEPAGE="http://www.mpir.org/"
SRC_URI="http://www.mpir.org/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+cxx cpudetection static-libs"

DEPEND="x86? ( dev-lang/yasm )
	amd64? ( dev-lang/yasm )"
RDEPEND=""

src_prepare(){
	epatch \
		"${FILESDIR}/${PN}-2.2.0-yasm.patch" \
		"${FILESDIR}/${PN}-1.3.0-ABI-multilib.patch"

	# In the same way there was QA regarding executable stacks
	# with GMP we have some here as well. We cannot apply the
	# GMP solution as yasm is used, at least on x86/amd64.
	# Furthermore we are able to patch config.ac.
	ebegin "Patching assembler files to remove executable sections"
	local i
	for i in $(find . -type f -name '*.asm') ; do
		cat >> $i <<-EOF
			#if defined(__linux__) && defined(__ELF__)
			.section .note.GNU-stack,"",%progbits
			#endif
		EOF
	done

	for i in $(find . -type f -name '*.as') ; do
		cat >> $i <<-EOF
			%ifidn __OUTPUT_FORMAT__,elf
			section .note.GNU-stack noalloc noexec nowrite progbits
			%endif
		EOF
	done
	eend
	eautoreconf
}

src_configure() {
# beware that cpudetection aka fat binaries is x86/amd64 only.
# Place mpir in profiles/arch/$arch/package.use.mask when making it available on $arch.
	myeconfargs=(
		$(use_enable cxx)
		$(use_enable cpudetection fat)
		$(use_enable static-libs static)
	)
	autotools-utils_src_configure
}
