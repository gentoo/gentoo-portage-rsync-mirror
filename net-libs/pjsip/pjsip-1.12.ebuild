# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/pjsip/pjsip-1.12.ebuild,v 1.3 2012/03/02 15:10:00 elvanor Exp $

EAPI="2"

DESCRIPTION="Multimedia communication libraries written in C language
for building VoIP applications."
HOMEPAGE="http://www.pjsip.org/"
SRC_URI="http://www.pjsip.org/release/${PV}/pjproject-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa cli doc epoll examples ext-sound g711 g722 g7221 gsm ilbc l16
oss python speex"
#small-filter large-filter speex-aec ssl

DEPEND="alsa? ( media-libs/alsa-lib )
	gsm? ( media-sound/gsm )
	ilbc? ( dev-libs/ilbc-rfc3951 )
	speex? ( media-libs/speex )"
	#ssl? ( dev-libs/openssl )
RDEPEND="${DEPEND}"

S="${WORKDIR}/pjproject-${PV}"

src_prepare() {
	# Remove target name from lib names
	sed -i -e 's/-$(TARGET_NAME)//g' \
		-e 's/= $(TARGET_NAME).a/= .a/g' \
		-e 's/-$(LIB_SUFFIX)/$(LIB_SUFFIX)/g' \
		$(find . -name '*.mak*' -o -name Makefile) || die "sed failed."

	# Fix hardcoded prefix and flags
	sed -i \
		-e 's/poll@/poll@\nexport PREFIX := @prefix@\n/g' \
		-e 's!prefix = /usr/local!prefix = $(PREFIX)!' \
		-e '/PJLIB_CFLAGS/ s/(_CFLAGS)/(_CFLAGS) -fPIC/g' \
		-e '/PJLIB_UTIL_CFLAGS/ s/(_CFLAGS)/(_CFLAGS) -fPIC/g' \
		Makefile \
		build.mak.in || die "sed failed."

	# TODO: remove deps to shipped codecs and libs, use system ones
	# rm -r third_party
	# libresample: https://ccrma.stanford.edu/~jos/resample/Free_Resampling_Software.html
}

src_configure() {
	# Disable through portage available codecs
	econf --disable-gsm-codec \
		--disable-speex-codec \
		--disable-ilbc-codec \
		--disable-speex-aec \
		$(use_enable epoll) \
		$(use_enable alsa sound) \
		$(use_enable oss) \
		$(use_enable ext-sound) \
		$(use_enable g711 g711-codec) \
		$(use_enable l16 l16-codec) \
		$(use_enable g722 g722-codec) \
		$(use_enable g7221 g7221-codec) || die "econf failed."
		#$(use_enable small-filter) \
		#$(use_enable large-filter) \
		#$(use_enable speex-aec) \
		#$(use_enable ssl) \ #broken? sflphone doesn't compile if enabled or disabled
}

src_compile() {
	emake dep || die "emake dep failed."
	emake -j1 || die "emake failed."
}

src_install() {
	DESTDIR="${D}" emake install || die "emake install failed."

	if use cli; then
		dobin pjsip-apps/bin/pjsua
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
		insinto "/usr/share/doc/${P}/examples"
		doins "${S}/pjsip-apps/src/samples/"*
	fi

	# Remove files that pjproject should not install
	rm -r "${D}/usr/lib/libportaudio.a" \
		"${D}/usr/lib/libsrtp.a"
}
