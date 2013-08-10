# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/orc/orc-0.4.17-r1.ebuild,v 1.1 2013/08/10 16:04:59 aballier Exp $

EAPI="5"
inherit autotools eutils flag-o-matic autotools-multilib

DESCRIPTION="The Oil Runtime Compiler, a just-in-time compiler for array operations"
HOMEPAGE="http://code.entropywave.com/projects/orc/"
SRC_URI="http://code.entropywave.com/download/orc/${P}.tar.gz"

LICENSE="BSD BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="static-libs examples"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am"

src_prepare() {
	if ! use examples; then
		sed -i -e '/SUBDIRS/s:examples::' Makefile.am || die
		epatch "${FILESDIR}/${P}-AM_CONFIG_HEADER.patch" # in 0.4.18
		AT_M4DIR="m4" eautoreconf
	fi
}

src_configure() {
	# any optimisation on PPC/Darwin yields in a complaint from the assembler
	# Parameter error: r0 not allowed for parameter %lu (code as 0 not r0)
	# the same for Intel/Darwin, although the error message there is different
	# but along the same lines
	[[ ${CHOST} == *-darwin* ]] && filter-flags -O*
	autotools-multilib_src_configure
}
