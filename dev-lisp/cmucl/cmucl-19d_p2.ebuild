# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl/cmucl-19d_p2.ebuild,v 1.6 2012/10/24 19:07:00 ulm Exp $

EAPI=1

inherit common-lisp-common-3 eutils toolchain-funcs

MY_PV=${PV:0:3}
MY_PVL=${PV}

DESCRIPTION="CMU Common Lisp is an implementation of ANSI Common Lisp"
HOMEPAGE="http://www.cons.org/cmucl/"
SRC_URI="http://common-lisp.net/project/cmucl/downloads/release/${MY_PV}/cmucl-src-${MY_PV}.tar.bz2
	http://common-lisp.net/project/cmucl/downloads/release/${MY_PV}/cmucl-${MY_PV}-x86-linux.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/motif-2.3:0
	sys-devel/bc"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${MY_PV}-gentoo.patch"
	epatch "${FILESDIR}/${MY_PV}-cmucl-patch-002.patch"
	find "${S}" -type f \( -name \*.sh -o -name linux-nm \) \
		-exec chmod +x '{}' \;
	sed -i -e "s,CC = .*,CC = $(tc-getCC),g" src/lisp/Config.linux_gencgc
	sed -i -e 's,"time","",g' src/tools/build.sh
	sed -i -e "s,@CFLAGS@,$CFLAGS,g" src/lisp/Config.linux_gencgc src/motif/server/Config.x86
}

src_compile() {
	export SANDBOX_ON=0
	src/tools/build.sh -C "" -o "bin/lisp -core lib/cmucl/lib/lisp.core -batch -noinit -nositeinit" || die
}

src_install() {
	src/tools/make-dist.sh -g -G root -O root build-4 ${MY_PVL} x86 linux
	dodir /usr/share/doc
	for i in cmucl-${MY_PVL}-x86-linux.{,extra.}tar.gz; do
		tar xzpf $i -C "${D}"/usr
	done
	mv "${D}"/usr/doc "${D}"/usr/share/doc/${PF}
	mv "${D}"/usr/man "${D}"/usr/share/
	impl-save-timestamp-hack cmucl || die
}

pkg_postinst() {
	standard-impl-postinst cmucl
}

pkg_postrm() {
	standard-impl-postrm cmucl /usr/bin/lisp
}

# pkg_postrm() {
#	if [ ! -x /usr/bin/lisp ]; then
#		rm -rf /usr/lib/cmucl/ || die
#	fi
# }
