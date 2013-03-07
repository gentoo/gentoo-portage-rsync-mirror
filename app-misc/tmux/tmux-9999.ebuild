# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tmux/tmux-9999.ebuild,v 1.9 2013/03/07 22:48:48 radhermit Exp $

EAPI=4

inherit autotools git-2 bash-completion-r1

EGIT_REPO_URI="git://git.code.sf.net/p/tmux/tmux-code"
EGIT_PROJECT="tmux"

DESCRIPTION="Terminal multiplexer"
HOMEPAGE="http://tmux.sourceforge.net"

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE="debug vim-syntax"

COMMON_DEPEND="
	>=dev-libs/libevent-2.0.10
	sys-libs/ncurses"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	vim-syntax? ( || (
		app-editors/vim
		app-editors/gvim ) )"

DOCS=( CHANGES FAQ TODO )

src_prepare() {
	eautoreconf
	# look for config file in the prefix
	sed -i -e '/SYSTEM_CFG/s:"/etc:"'"${EPREFIX}"'/etc:' tmux.h || die
	# and don't just add some includes
	sed -i -e 's:-I/usr/local/include::' Makefile.in || die
}

src_configure() {
	econf \
		$(use_enable debug)
}

src_install() {
	default

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
