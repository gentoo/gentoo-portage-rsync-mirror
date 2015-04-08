# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/orc/orc-0.4.23.ebuild,v 1.5 2015/03/29 10:25:55 jer Exp $

EAPI="5"

inherit autotools-multilib flag-o-matic

DESCRIPTION="The Oil Runtime Compiler, a just-in-time compiler for array operations"
HOMEPAGE="http://gstreamer.freedesktop.org/"
SRC_URI="http://gstreamer.freedesktop.org/src/${PN}/${P}.tar.xz"

LICENSE="BSD BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="examples static-libs"

RDEPEND=""
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.12
"

src_prepare() {
	if ! use examples; then
		sed -e '/SUBDIRS/ s:examples::' \
			-i Makefile.am Makefile.in || die
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
