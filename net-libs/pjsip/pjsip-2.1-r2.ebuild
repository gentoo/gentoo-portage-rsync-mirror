# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/pjsip/pjsip-2.1-r2.ebuild,v 1.3 2014/03/09 13:07:51 aballier Exp $

EAPI="5"

inherit eutils multilib

DESCRIPTION="Multimedia communication libraries written in C language for building VoIP applications"
HOMEPAGE="http://www.pjsip.org/"
SRC_URI="http://www.pjsip.org/release/${PV}/pjproject-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa cli doc examples ext-sound ffmpeg g711 g722 g7221 gsm ilbc l16 oss python speex"
#small-filter large-filter speex-aec ssl

DEPEND="alsa? ( media-libs/alsa-lib )
	ffmpeg? ( >=virtual/ffmpeg-9 )
	gsm? ( media-sound/gsm )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	speex? ( media-libs/speex )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/pjproject-${PV}.0"

src_prepare() {
	# bug #469582
	epatch "${FILESDIR}/${P}-new-ffmpeg-workaround.patch"
	# bug #496430
	epatch "${FILESDIR}/${P}-multilib.patch"
	# bug #498454
	epatch "${FILESDIR}/${P}-codecid.patch"

	epatch_user
}

src_configure() {
	# Disable through portage available codecs
	# libdir should be defined explicitly, bug #497744
	econf \
		--libdir="/usr/$(get_libdir)" \
		--disable-gsm-codec \
		--disable-speex-codec \
		--disable-ilbc-codec \
		--disable-speex-aec \
		$(use_enable alsa sound) \
		$(use_enable oss) \
		$(use_enable ext-sound) \
		$(use ffmpeg || echo '--disable-ffmpeg') \
		$(use_enable g711 g711-codec) \
		$(use_enable l16 l16-codec) \
		$(use_enable g722 g722-codec) \
		$(use_enable g7221 g7221-codec)
		#$(use_enable small-filter) \
		#$(use_enable large-filter) \
		#$(use_enable speex-aec) \
		#$(use_enable ssl tls) #broken? sflphone doesn't compile if enabled or disabled
}

src_compile() {
	emake dep
	emake -j1
}

src_install() {
	DESTDIR="${D}" emake install

	if use cli; then
		newbin pjsip-apps/bin/pjsua* pjsua
	fi

	if use python; then
		pushd pjsip-apps/src/python
		python setup.py install --prefix="${D}/usr/"
		popd
	fi

	if use doc; then
		dodoc README.txt README-RTEMS
	fi

	if use examples; then
		docinto examples
		docompress -x "/usr/share/doc/${PF}/examples"
		dodoc pjsip-apps/src/samples/*
	fi
}
