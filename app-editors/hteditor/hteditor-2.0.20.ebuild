# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/hteditor/hteditor-2.0.20.ebuild,v 1.7 2012/10/17 03:35:50 phajdan.jr Exp $

EAPI=4

inherit toolchain-funcs

MY_P=${P/editor}

DESCRIPTION="A file viewer, editor and analyzer for text, binary, and executable files"
HOMEPAGE="http://hte.sourceforge.net/"
SRC_URI="mirror://sourceforge/hte/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="X"

RDEPEND="sys-libs/ncurses
	X? ( x11-libs/libX11 )
	>=dev-libs/lzo-2"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

DOCS=( AUTHORS ChangeLog KNOWNBUGS README TODO )

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e '/FLAGS_ALL/s:-ggdb -g3 -O0::' \
		configure || die
}

src_configure() {
	econf \
		$(use_enable X x11-textmode) \
		--disable-release
}

src_compile() {
	emake AR="$(tc-getAR)"
}

src_install() {
	#For prefix
	chmod u+x "${S}/install-sh"

	default

	dohtml doc/*.html
	doinfo doc/*.info
}
