# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jack-audio-connection-kit/jack-audio-connection-kit-0.109.2-r1.ebuild,v 1.11 2012/05/05 08:31:44 mgorny Exp $

inherit flag-o-matic eutils multilib linux-info autotools multilib

NETJACK=netjack-0.12

DESCRIPTION="A low-latency audio server"
HOMEPAGE="http://www.jackaudio.org"
SRC_URI="mirror://sourceforge/jackit/${P}.tar.gz netjack? ( mirror://sourceforge/netjack/${NETJACK}.tar.bz2 )"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE="altivec alsa caps coreaudio doc debug mmx oss sse netjack cpudetection"

RDEPEND=">=media-libs/libsndfile-1.0.0
	sys-libs/ncurses
	caps? ( sys-libs/libcap )
	alsa? ( >=media-libs/alsa-lib-0.9.1 )
	netjack? ( media-libs/libsamplerate )
	!media-sound/jack-cvs"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	netjack? ( dev-util/scons )"

pkg_setup() {
	if use caps; then
		if kernel_is 2 4 ; then
			einfo "will build jackstart for 2.4 kernel"
		else
			einfo "using compatibility symlink for jackstart"
		fi
	fi

	if use netjack; then
		einfo "including support for experimental netjack, see http://netjack.sourceforge.net/"
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${PN}-transport.patch"
	epatch "${FILESDIR}/${PN}-0.103.0-riceitdown.patch"
	epatch "${FILESDIR}/${PN}-0.103.0-ppc64fix.patch"
	epatch "${FILESDIR}/${PN}-sparc-cpuinfo.patch"

	eautoreconf
}

src_compile() {
	local myconf=""

	if [[ ${CHOST} == *-darwin* ]] ; then
		append-flags -fno-common
		use altivec && append-flags -force_cpusubtype_ALL \
			-maltivec -mabi=altivec -mhard-float -mpowerpc-gfxopt
	fi

	# CPU Detection (dynsimd) uses asm routines which requires 3dnow, mmx and sse.
	# Also, without -O2 it will not compile as well.
	# we test if it is present before enabling the configure flag.
	if use cpudetection ; then
		if (! grep 3dnow /proc/cpuinfo >/dev/null) ; then
			ewarn "Can't build cpudetection (dynsimd) without cpu 3dnow support. see bug #136565."
		elif (! grep sse /proc/cpuinfo >/dev/null) ; then
			ewarn "Can't build cpudetection (dynsimd) without cpu sse support. see bug #136565."
		elif (! grep mmx /proc/cpuinfo >/dev/null) ; then
			ewarn "Can't build cpudetection (dynsimd) without cpu mmx support. see bug #136565."
		else
			einfo "Enabling cpudetection (dynsimd). Adding -mmmx, -msse, -m3dnow and -O2 to CFLAGS."
			myconf="${myconf} --enable-dynsimd"

			filter-flags -O*
			append-flags -mmmx -msse -m3dnow -O2
		fi
	fi

	use doc || export ac_cv_prog_HAVE_DOXYGEN=false

	econf \
		$(use_enable altivec) \
		$(use_enable alsa) \
		$(use_enable caps capabilities) \
		$(use_enable coreaudio) \
		$(use_enable debug) \
		$(use_enable mmx) \
		$(use_enable oss) \
		--disable-portaudio \
		$(use_enable sse) \
		--with-html-dir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		${myconf} || die "configure failed"
	emake || die "compilation failed"

	if use caps && kernel_is 2 4 ; then
		einfo "Building jackstart for 2.4 kernel"
		cd "${S}/jackd"
		emake jackstart || die "jackstart build failed."
	fi

	if use netjack; then
		cd "${WORKDIR}/${NETJACK}"
		scons jack_source_dir="${S}"
	fi

}

src_install() {
	make DESTDIR="${D}" install || die

	if use caps; then
		if kernel_is 2 4 ; then
			cd "${S}/jackd"
			dobin jackstart
		else
			dosym /usr/bin/jackd /usr/bin/jackstart
		fi
	fi

	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r "${S}/example-clients"
	fi

	if use netjack; then
		cd "${WORKDIR}/${NETJACK}"
		dobin alsa_in
		dobin alsa_out
		dobin jacknet_client
		insinto /usr/$(get_libdir)/jack
		doins jack_net.so
	fi
}
