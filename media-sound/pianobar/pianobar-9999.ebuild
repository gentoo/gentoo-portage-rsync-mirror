# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/pianobar/pianobar-9999.ebuild,v 1.7 2014/03/01 22:16:51 mgorny Exp $

EAPI="5"

inherit toolchain-funcs flag-o-matic multilib git-r3

EGIT_REPO_URI="git://github.com/PromyLOPh/pianobar.git"

DESCRIPTION="A console-based replacement for Pandora's flash player"
HOMEPAGE="http://6xq.net/projects/pianobar/"

LICENSE="MIT"
SLOT="0"
IUSE="+aac mp3 static-libs"

RDEPEND="media-libs/libao
	net-libs/gnutls
	dev-libs/libgcrypt:0
	dev-libs/json-c
	aac? ( media-libs/faad2 )
	mp3? ( media-libs/libmad )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

REQUIRED_USE="|| ( aac mp3 )"

src_prepare() {
	sed -e '/@echo /d' \
		-e 's/@${CC}/${CC}/' \
		-i Makefile || die
}

src_compile() {
	local myconf="DYNLINK=1"
	! use aac && myconf+=" DISABLE_FAAD=1"
	! use mp3 && myconf+=" DISABLE_MAD=1"

	append-cflags -std=c99
	tc-export CC
	emake ${myconf}
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr LIBDIR=/usr/$(get_libdir) DYNLINK=1 install
	dodoc ChangeLog README

	use static-libs || rm -f "${D}"/usr/lib*/*.a

	docinto contrib
	dodoc -r contrib/{config-example,*.sh,eventcmd-examples}
	docompress -x /usr/share/doc/${PF}/contrib
}
