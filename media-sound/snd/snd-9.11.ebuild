# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/snd/snd-9.11.ebuild,v 1.9 2012/10/24 19:16:45 ulm Exp $

EAPI=1

inherit multilib eutils versionator

DESCRIPTION="Snd is a sound editor"
HOMEPAGE="http://ccrma.stanford.edu/software/snd/"
SRC_URI="ftp://ccrma-ftp.stanford.edu/pub/Lisp/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 ppc x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="alsa cairo fam fftw gsl gtk guile jack ladspa motif nls opengl oss ruby xpm"

RDEPEND="media-libs/audiofile
	motif? ( >=x11-libs/motif-2.3:0 )
	alsa? ( media-libs/alsa-lib )
	fam? ( virtual/fam )
	fftw? ( sci-libs/fftw )
	gsl? ( >=sci-libs/gsl-0.8 )
	gtk? ( x11-libs/gtk+:2
		opengl? ( x11-libs/gtkglext )
		cairo? ( x11-libs/cairo ) )
	guile? ( >=dev-scheme/guile-1.3.4 )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/ladspa-sdk )
	nls? ( sys-devel/gettext )
	opengl? ( virtual/opengl )
	ruby? ( dev-lang/ruby )
	xpm? ( x11-libs/libXpm )"

#S=${WORKDIR}/${PN}-$(get_version_component_range 1)

pkg_setup() {
	if ! use gtk && ! use motif; then
		ewarn "Warning: no graphic toolkit selected (gtk or motif)."
		ewarn "Upstream suggests to enable one of the toolkits (or both)"
		ewarn "or only the command line utilities will be helpful."
	fi
}

src_compile() {
	local myconf

	if use opengl; then
		if use guile; then
			myconf="${myconf} --with-gl"
		else
			myconf="${myconf} --with-just-gl"
		fi
	else
		myconf="${myconf} --without-gl"
	fi

	econf \
		$(use_with alsa) \
		$(use_with oss) \
		--without-esd \
		$(use_with fam) \
		$(use_with fftw) \
		$(use_with gsl) \
		$(use_with gtk) \
		$(use_with guile) \
		$(use_with jack) \
		$(use_with ladspa) \
		$(use_with motif) \
		$(use_enable nls) \
		$(use_with ruby) \
		$(use_with cairo) \
		$(use_with xpm) \
		--with-float-samples \
		${myconf} || die

	emake snd || die "emake snd failed"

	# compiling command-line programs. See bug #112695
	# do not compile ruby extensions for command line programs
	# those fail to compile
	if use ruby; then
		econf \
			$(use_with alsa) \
			--without-esd \
			$(use_with fam) \
			$(use_with fftw) \
			$(use_with gsl) \
			$(use_with gtk) \
			$(use_with guile) \
			$(use_with jack) \
			$(use_with ladspa) \
			$(use_with motif) \
			$(use_enable nls) \
			$(use_with xpm) \
			--without-ruby \
			--with-float-samples \
			${myconf} || die
	fi

	for i in sndrecord sndinfo audinfo sndplay; do
		emake ${i} || die "make ${i} failed"
	done
}

src_install () {
	dobin snd
	dobin sndplay
	dobin sndrecord
	dobin sndinfo
	dobin audinfo

	insinto /usr/$(get_libdir)/snd/scheme
	doins *.scm

	dodoc README.Snd HISTORY.Snd TODO.Snd Snd.ad
	dohtml -r *.html *.png tutorial
}
