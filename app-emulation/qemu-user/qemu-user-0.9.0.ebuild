# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qemu-user/qemu-user-0.9.0.ebuild,v 1.7 2009/09/23 15:34:15 patrick Exp $

inherit eutils flag-o-matic

DESCRIPTION="Multi-platform & multi-targets cpu emulator and dynamic translator"
HOMEPAGE="http://fabrice.bellard.free.fr/qemu/"
SRC_URI="http://fabrice.bellard.free.fr/qemu/${P/-user/}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="-alpha amd64 ppc -sparc x86"
IUSE=""  #qvm86 debug nptl qemu-fast nptlonly"
RESTRICT="strip test"

DEPEND="app-text/texi2html
	!<=app-emulation/qemu-0.7.0"
RDEPEND=""

S="${WORKDIR}/${P/-user/}"

QA_TEXTRELS="usr/bin/qemu-armeb
	usr/bin/qemu-i386
	usr/bin/qemu-mips
	usr/bin/qemu-arm
	usr/bin/qemu-ppc"

#set_target_list() {
#	TARGET_LIST="i386-user ppc-user mips-user"
# arm broken
#	TARGET_LIST="arm-user armeb-user i386-user ppc-user mips-user"
#	export TARGET_LIST
#}

#pkg_setup() {
#	if [ "$(gcc-major-version)" == "4" ]; then
#		die "Qemu must build with GCC 3"
#	fi
#}

#RUNTIME_PATH="/emul/gnemul/"
src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/qemu-0.7.0-ppc-linker.patch

	# Alter target makefiles to accept CFLAGS set via flag-o.
	sed -i 's/^\(C\|OP_C\|HELPER_C\)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target tests/Makefile
	# Ensure mprotect restrictions are relaxed for emulator binaries
	[[ -x /sbin/paxctl ]] && \
		sed -i 's/^VL_LDFLAGS=$/VL_LDFLAGS=-Wl,-z,execheap/' \
			Makefile.target
	# Prevent install of kernel module by qemu's makefile
	sed -i 's/\(.\/install.sh\)/#\1/' Makefile
	# avoid strip
	sed -i 's:$(INSTALL) -m 755 -s:$(INSTALL) -m 755:' Makefile Makefile.target
}

src_compile() {
	#Let the application set its cflags
	unset CFLAGS

	# Switch off hardened tech
	filter-flags -fpie -fstack-protector

	myconf="--disable-gcc-check"
#	set_target_list
#		--interp-prefix=${RUNTIME_PATH}/qemu-%M
	./configure \
		--prefix=/usr \
		--enable-slirp \
		--kernel-path=${KV_DIR} \
		--enable-linux-user \
		--disable-system \
		${myconf} \
		|| die "could not configure"

	emake || die "make failed"
}

src_install() {
	make install \
		prefix=${D}/usr \
		bindir=${D}/usr/bin \
		datadir=${D}/usr/share/qemu \
		docdir=${D}/usr/share/doc/${P} \
		mandir=${D}/usr/share/man || die

	rm -fR ${D}/usr/share/{man,qemu}
	rm -fR ${D}/usr/bin/qemu-img
}
