# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/chuck/chuck-1.2.1.3-r1.ebuild,v 1.1 2012/07/31 16:23:33 cedk Exp $

EAPI=2
inherit toolchain-funcs flag-o-matic eutils

DESCRIPTION="Strongly-timed, Concurrent, and On-the-fly
Audio Programming Language"
HOMEPAGE="http://chuck.cs.princeton.edu/release/"
SRC_URI="http://chuck.cs.princeton.edu/release/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+alsa jack oss examples"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	alsa? ( media-libs/alsa-lib )
	media-libs/libsndfile
	app-admin/eselect-chuck"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

pkg_setup() {
	if ! use alsa && ! use jack && ! use oss; then
		eerror "One of the following USE flags is needed: jack, alsa or oss"
		die "Please set one audio engine type"
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.1.1-hid-smc.patch \
		"${FILESDIR}"/${PN}-1.2.1.2-gcc44.patch
	sed -i \
		-e "s/\$(CXX) -o/\$(CXX) \$(LDFLAGS) -o/" \
		src/makefile.{alsa,jack,oss} || die "sed failed"
}

compile_backend() {
	backend=$1
	cd "${S}/src"
	einfo "Compiling against ${backend}"
	emake -f "makefile.${backend}" CC=$(tc-getCC) \
		CXX=$(tc-getCXX) || die "emake failed"
	mv chuck{,-${backend}}
	emake -f "makefile.${backend}" clean
	cd -
}

src_compile() {
	# when compile with athlon or athlon-xp flags
	# chuck crashes on removing a shred with a double free or corruption
	# it happens in Chuck_VM_Stack::shutdown() on the line
	#   SAFE_DELETE_ARRAY( stack );
	replace-cpu-flags athlon athlon-xp i686

	use jack && compile_backend jack
	use alsa && compile_backend alsa
	use oss && compile_backend oss
}

src_install() {
	use jack && dobin src/chuck-jack
	use alsa && dobin src/chuck-alsa
	use oss && dobin src/chuck-oss

	dodoc AUTHORS DEVELOPER PROGRAMMER QUICKSTART README THANKS TODO VERSIONS
	docinto doc
	dodoc doc/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins $(find examples -type f)
		for dir in $(find examples/* -type d); do
			insinto /usr/share/doc/${PF}/"${dir}"
			doins "${dir}"/*
		done
	fi
}

pkg_postinst() {
	elog "Chuck now can use many audio engines, so you can specify audio engine"
	elog "with chuck-{jack,alsa,oss}"
	elog "Or you can use 'eselect chuck' to set the audio engine"

	einfo "Calling eselect chuck update..."
	eselect chuck update --if-unset
}
