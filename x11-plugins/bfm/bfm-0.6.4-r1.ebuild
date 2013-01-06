# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/bfm/bfm-0.6.4-r1.ebuild,v 1.10 2012/05/05 05:12:01 jdhore Exp $

EAPI="1"

inherit multilib toolchain-funcs

DESCRIPTION="a dockapp and gkrellm plug-in combining timecop's bubblemon and wmfishtime."
HOMEPAGE="http://www.jnrowe.ukfsn.org/projects/bfm.html"
SRC_URI="http://www.jnrowe.ukfsn.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~amd64-linux ~x86-linux"
IUSE="gkrellm"

RDEPEND="x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	gkrellm? ( >=app-admin/gkrellm-2 )"

src_unpack() {
	unpack ${A}
	sed -e 's:CFLAGS =:CFLAGS +=:' -e 's:LDFLAGS =:LDFLAGS +=:' -e 's:strip:true:' \
		-e 's:$(CFLAGS) -o $(BUBBLEFISHYMON):$(CFLAGS) $(SRCS) -o $(BUBBLEFISHYMON):' \
		-e 's:$(LIBS) $(GTK2_LIBS) $(SRCS):$(LIBS) $(GTK2_LIBS):' \
		-e 's:-o $(BUBBLEFISHYMON):$(GENTOO_LDFLAGS) -o $(BUBBLEFISHYMON):' \
		-i "${S}"/Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" GENTOO_LDFLAGS="${LDFLAGS}" || die "emake failed."

	if use gkrellm; then
		emake gkrellm CC="$(tc-getCC)" || die "emake failed."
	fi
}

src_install() {
	dobin bubblefishymon

	doman doc/*.1
	dodoc ChangeLog* README* doc/*.sample

	if use gkrellm; then
		insinto /usr/$(get_libdir)/gkrellm2/plugins
		doins gkrellm-bfm.so
	fi
}
