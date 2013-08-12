# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-user/qemu-user-0.12.2.ebuild,v 1.2 2013/08/12 14:45:44 pinkbyte Exp $

inherit eutils flag-o-matic pax-utils toolchain-funcs

MY_PN=${PN/-user/}
MY_P=${P/-user/}

SRC_URI="http://savannah.nongnu.org/download/${MY_PN}/${MY_P}.tar.gz"

DESCRIPTION="Open source dynamic translator"
HOMEPAGE="http://bellard.org/qemu/index.html"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc64"
IUSE="static"
RESTRICT="test"

DEPEND="app-text/texi2html
	!<=app-emulation/qemu-0.7.0"
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# prevent docs to get automatically installed
	sed -i '/$(DESTDIR)$(docdir)/d' Makefile
	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target
}

src_compile() {
	local conf_opts

	conf_opts="--enable-linux-user --disable-strip"
	conf_opts+=" --disable-darwin-user --disable-bsd-user"
	conf_opts+=" --disable-system"
	conf_opts+=" --disable-vnc-tls"
	conf_opts+=" --disable-curses"
	conf_opts+=" --disable-sdl"
	conf_opts+=" --disable-vde"
	conf_opts+=" --prefix=/usr --disable-bluez --disable-kvm"
	conf_opts+=" --cc=$(tc-getCC) --host-cc=$(tc-getBUILD_CC)"
	conf_opts+=" --extra-ldflags=-Wl,-z,execheap"
	use static && conf_opts+=" --static"

	filter-flags -fpie -fstack-protector

	./configure ${conf_opts} || die "econf failed"

	# enable verbose build, bug #444346
	emake V=1 || die "emake qemu failed"

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	pax-mark r "${D}"/usr/bin/qemu-*
	rm -fR "${D}/usr/share"
	dohtml qemu-doc.html
	dohtml qemu-tech.html
}
