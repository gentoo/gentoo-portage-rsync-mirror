# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-1.8.ebuild,v 1.6 2013/05/14 14:06:18 jer Exp $

EAPI=5

AUTOTOOLS_AUTORECONF=true

inherit autotools-utils bash-completion-r1 flag-o-matic

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"
SRC_URI="mirror://sourceforge/tmux/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="vim-syntax"

COMMON_DEPEND="
	>=dev-libs/libevent-2.0.10
	sys-libs/ncurses"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	vim-syntax? ( || (
		app-editors/vim
		app-editors/gvim ) )"

DOCS=( CHANGES FAQ README TODO )

PATCHES=( "${FILESDIR}"/${PN}-1.7-terminfo.patch )

pkg_setup() {
	if has_version "<app-misc/tmux-1.7"; then
		echo
		ewarn "Some configuration options changed in this release."
		ewarn "Please read the CHANGES file in /usr/share/doc/${PF}/"
		ewarn
		ewarn "WARNING: after updating to ${P} you will _not_ be able to connect to any"
		ewarn "running 1.6 tmux server instances. You'll have to use an existing client to"
		ewarn "end your old sessions or kill the old server instances. Otherwise you'll have"
		ewarn "to temporarily downgrade to tmux 1.6 to access them."
		echo
	fi
}

src_prepare() {
	# look for config file in the prefix
	sed -i -e '/SYSTEM_CFG/s:"/etc:"'"${EPREFIX}"'/etc:' tmux.h || die
	# and don't just add some includes
	sed -i -e 's:-I/usr/local/include::' Makefile.am || die

	# bug 438558
	# 1.7 segfaults when entering copy mode if compiled with -Os
	replace-flags -Os -O2

	# regenerate aclocal.m4 to support earlier automake versions
	rm aclocal.m4

	autotools-utils_src_prepare
}

src_install() {
	autotools-utils_src_install

	newbashcomp examples/bash_completion_tmux.sh ${PN}

	docinto examples
	dodoc examples/*.conf

	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins examples/tmux.vim

		insinto /usr/share/vim/vimfiles/ftdetect
		doins "${FILESDIR}"/tmux.vim
	fi
}
