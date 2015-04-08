# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmtcp/dmtcp-1.2.1.ebuild,v 1.4 2014/08/10 20:23:39 slyfox Exp $

EAPI=3

inherit autotools elisp-common eutils multilib

DESCRIPTION="DMTCP is the Distributed MultiThreaded Checkpointing tool"
HOMEPAGE="http://dmtcp.sourceforge.net/index.html"
SRC_URI="mirror://sourceforge/dmtcp/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug emacs fast mpi trace"

RDEPEND="sys-libs/readline
	app-arch/gzip
	sys-kernel/linux-headers
	emacs? ( dev-lisp/clisp )
	mpi? ( virtual/mpi )
	|| ( app-shells/dash
		app-shells/zsh
		app-shells/tcsh
	)"

DEPEND="${RDEPEND}
	sys-devel/patch"

src_prepare() {
	sed -i -e "s|(cd dmtcp && make install)|\$(MAKE) -C dmtcp install|" \
		Makefile.in || die "sed make syntax failed"
	sed -i -e "s/LDFLAGS =/LDFLAGS +=/g" \
		mtcp/Makefile || die "sed ldflags failed"

	epatch "${FILESDIR}"/${P}-gcc46.patch

	eautoreconf
}

src_configure() {
	local myconf="--enable-external-socket-handling \
		--disable-stale-socket-handling"

	if use debug; then
		use trace && myconf=" ${myconf} --enable-ptrace-support"
		myconf=" ${myconf} --disable-pid-virtualization"
	fi

	use fast && myconf=" ${myconf} --disable-pid-virtualization \
		--disable-external-socket-handling \
		--enable-forked-checkpointing \
		--enable-allocator"

	use mpi && myconf=" ${myconf} --with-mpich=/usr/bin"

	econf $(use_enable debug) $myconf
}

src_test() {
	make check || die "make check failed"
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc TODO QUICK-START ${PN}/README

	dodir /usr/share/${PF}/examples
	mv "${D}"usr/$(get_libdir)/${PN}/examples "${D}"usr/share/${PF}/examples
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
