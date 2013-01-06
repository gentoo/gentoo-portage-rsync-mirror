# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl/cmucl-20a.ebuild,v 1.6 2012/10/24 19:07:00 ulm Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

MY_PV=${PV:0:3}

DESCRIPTION="CMU Common Lisp is an implementation of ANSI Common Lisp"
HOMEPAGE="http://www.cons.org/cmucl/"
SRC_URI="http://common-lisp.net/project/cmucl/downloads/release/${MY_PV}/cmucl-src-${MY_PV}.tar.bz2
	http://common-lisp.net/project/cmucl/downloads/release/${MY_PV}/cmucl-${MY_PV}-x86-linux.tar.bz2"
RESTRICT="mirror"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"
IUSE="X source sse2"

RDEPEND=">=x11-libs/motif-2.3:0"
DEPEND="${RDEPEND}
		sys-devel/bc"
PDEPEND="dev-lisp/gentoo-init"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/fix-man-and-doc-installation.patch
	epatch "${FILESDIR}"/${MY_PV}-patch000.patch
	epatch "${FILESDIR}"/${MY_PV}-multiplefixes.patch
}

src_compile() {
	local cfpu="sse2"
	if ! use sse2; then
		cfpu="x87"
	fi

	einfo ${cfpu}

	local copts="-u"

	if use X; then
		copts=""
	fi

	copts+=" -f ${cfpu}"

	local buildimage="bin/lisp -core lib/cmucl/lib/lisp-${cfpu}.core -batch -noinit -nositeinit"
	env CC="$(tc-getCC)" src/tools/build.sh -C "" -o "${buildimage}" ${copts} || die "Cannot build the compiler"
}

src_install() {
	env MANDIR=share/man/man1 DOCDIR=share/doc/${PF} \
		src/tools/make-dist.sh -S -g -G root -O root build-4 ${MY_PV} x86 linux || die "Cannot build installation archive"

	dodir /usr || die "dodir failed"

	tar xzpf cmucl-${MY_PV}-x86-linux.tar.gz -C "${D}"/usr || die "Cannot install main system"
	if use X ; then
		tar xzpf cmucl-${MY_PV}-x86-linux.extra.tar.gz -C "${D}"/usr || die "Cannot install extra files"
	fi
	if use source; then
		dodir /usr/share/common-lisp/source/${PN} || die "dodir failed"
		tar --strip-components 1 -xzpf cmucl-src-${MY_PV}.tar.gz \
			-C "${D}"/usr/share/common-lisp/source/${PN} \
			|| die "tar failed"
	fi

	# Install site config file
	sed "s,@PF@,${PF},g ; s,@VERSION@,$(date +%F),g" \
		< "${FILESDIR}"/site-init.lisp.in \
		> "${D}"/usr/$(get_libdir)/cmucl/site-init.lisp || die "sed failed"
	insinto /etc
	doins "${FILESDIR}"/cmuclrc || die "doins failed"
}
