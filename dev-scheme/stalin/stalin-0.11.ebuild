# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/stalin/stalin-0.11.ebuild,v 1.3 2008/06/02 22:06:26 pchrist Exp $

inherit eutils

DESCRIPTION="An aggressively optimizing Scheme compiler."
HOMEPAGE="http://community.schemewiki.org/?Stalin"
SRC_URI="ftp://ftp.ecn.purdue.edu/qobi/${P}.tgz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="strip"
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's/-O3 -fomit-frame-pointer/$(CFLAGS)/' makefile
}

pkg_setup() {
	ewarn "Stalin is an ugly beast, which will eat all your memory and stress your"
	ewarn "processor to levels you have never experienced. If you want to abort,"
	ewarn "please do it now. You have been warned."
}

src_compile() {
	einfo "Beginning of stalin's compilation process. It may take several minutes."
	./build || die "Stalin's compilation failed"
}

src_test() {
	einfo "This may take REALLY much time and requires"
	einfo "possibly more than 2Gb of RAM+swap."
	cd benchmarks
	./compile-and-run-stalin-old-benchmarks || die "old benchmarks failed"
	#./compile-and-run-stalin-bcl-benchmarks || die "bcl bechmarks failed"
	#./compile-and-run-stalin-fdlcc-benchmarks || die "fdlcc benchmarks failed"
}

src_install() {
	pushd include
		dodir /usr/include/${PN}
		insinto /usr/include/${PN}
		doins gc.h gc_config_macros.h
		dodir /usr/lib/${PN}
		insinto /usr/lib/${PN}
		doins libgc.a libstalin.a stalin stalin-architecture-name \
		stalin.architectures QobiScheme.sc xlib.sc xlib-original.sc \
		Scheme-to-C-compatibility.sc
		fperms 755 /usr/lib/${PN}/stalin \
		/usr/lib/${PN}/stalin-architecture-name
	popd
(
cat <<'EOF'
#!/bin/bash

exec /usr/lib/stalin/stalin -I /usr/include/stalin \
-I /usr/lib/stalin -copt -fno-strict-aliasing $@

EOF
) > stalin
	exeinto /usr/bin
	doexe stalin
	doman stalin.1
	dodoc ANNOUNCEMENT MORE README
	pushd benchmarks
		sed -i -e 's/..\/stalin/stalin/' make-hello
		dodoc hello.sc make-hello
	popd
}

pkg_postinst() {
	elog "In ${ROOT}/usr/share/doc/${PF} you will find the make-hello and"
	elog "hello.sc files(compressed). If you put them in the same directory"
	elog "and run make.hello, it will produce a \"hello\" executable."
	elog "The \"make-hello\" file can be used as an example of how to use"
	elog "stalin to compile code and create efficient executables. "
	elog "man stalin , for documentation"
}
