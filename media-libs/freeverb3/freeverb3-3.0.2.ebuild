# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freeverb3/freeverb3-3.0.2.ebuild,v 1.1 2013/11/19 21:31:08 sping Exp $

EAPI=5
inherit multilib versionator

DESCRIPTION="High Quality Reverb and Impulse Response Convolution library including XMMS/Audacious Effect plugins"
HOMEPAGE="http://freeverb3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
_IUSE_INSTRUCTION_SETS="3dnow avx sse sse2 sse3 sse4"
IUSE="${_IUSE_INSTRUCTION_SETS} audacious forcefpu jack openmp plugdouble threads"

_GTK_DEPEND=">=dev-libs/glib-2.4.7:2
	>=x11-libs/gtk+-3.0.0:3
	x11-libs/pango
	x11-libs/cairo"

RDEPEND=">=sci-libs/fftw-3.0.1
	audacious? ( >=media-sound/audacious-3.2.4
		${_GTK_DEPEND}
		media-libs/libsndfile )
	jack? ( media-sound/jack-audio-connection-kit
		${_GTK_DEPEND}
		media-libs/libsndfile )"
DEPEND=${RDEPEND}

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_configure() {
	econf \
        --disable-profile \
		--enable-release \
		--disable-autocflags \
		--enable-undenormal \
		$(use_enable threads pthread) \
		$(use_enable forcefpu) \
		--disable-force3dnow \
		$(use_enable 3dnow) \
		$(use_enable sse) \
		$(use_enable sse2) \
		$(use_enable sse3) \
		$(use_enable sse4) \
		$(use_enable avx) \
		--disable-fma \
		--disable-fma4 \
		$(use_enable openmp omp) \
		--disable-sample \
		$(use_enable jack) \
		$(use_enable audacious) \
		--disable-srcnewcoeffs \
		$(use_enable plugdouble) \
		--disable-pluginit \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README || die 'dodoc failed'

	if use audacious ; then
		find "${D}/usr/$(get_libdir)/audacious/" -name '*.la' -print -delete || die
	fi

	insinto /usr/share/${PN}/samples/IR
	doins samples/IR/*.wav || die
}
