# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/google-perftools/google-perftools-2.0-r1.ebuild,v 1.1 2013/01/20 23:48:29 robbat2 Exp $

EAPI=4

MY_P="gperftools-${PV}"

inherit toolchain-funcs eutils flag-o-matic

DESCRIPTION="Fast, multi-threaded malloc() and nifty performance analysis tools"
HOMEPAGE="http://code.google.com/p/gperftools/"
SRC_URI="http://gperftools.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
# contains ASM code, with support for
# freebsd x86/amd64
# linux x86/amd64/ppc/ppc64/arm
# OSX ppc/amd64
# AIX ppc/ppc64
KEYWORDS="-* ~arm ~amd64 ~ppc64 ~x86 ~x86-fbsd"
IUSE="largepages +debug minimal test"

DEPEND="sys-libs/libunwind"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	# set up the make options in here so that we can actually make use
	# of them on both compile and install.

	# Avoid building the unit testing if we're not going to execute
	# tests; this trick here allows us to ignore the tests without
	# touching the build system (and thus without rebuilding
	# autotools). Keep commented as long as it's restricted.
	use test || \
		makeopts="${makeopts} noinst_PROGRAMS= "

	# don't install _anything_ from the documentation, since it would
	# install it in non-standard locations, and would just waste time.
	makeopts="${makeopts} dist_doc_DATA= "
}

src_prepare() {
	epatch "${FILESDIR}/${MY_P}+glibc-2.16.patch"
	epatch "${FILESDIR}/${MY_P}-32bit-barrier.patch"
}

src_configure() {
	use largepages && append-cppflags -DTCMALLOC_LARGE_PAGES

	append-flags -fno-strict-aliasing -fno-omit-frame-pointer

	econf \
		--disable-static \
		--disable-dependency-tracking \
		--enable-fast-install \
		$(use_enable debug debugalloc) \
		$(use_enable minimal)
}

src_compile() {
	emake ${makeopts}
}

src_test() {
	case "${LD_PRELOAD}" in
		*libsandbox*)
			ewarn "Unable to run tests when sanbox is enabled."
			ewarn "See http://bugs.gentoo.org/290249"
			return 0
			;;
	esac

	emake check
}

src_install() {
	emake DESTDIR="${D}" install ${makeopts}

	# Remove libtool files since we dropped the static libraries
	find "${D}" -name '*.la' -delete

	dodoc README AUTHORS ChangeLog TODO NEWS
	pushd doc
	dohtml -r *
	popd
}
