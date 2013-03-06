# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/linphone/linphone-3.1.1.ebuild,v 1.9 2013/03/06 13:20:30 chithanh Exp $

EAPI="2"

inherit eutils autotools multilib

DESCRIPTION="Video softphone based on the SIP protocol"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/stable/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc gtk ipv6 ncurses nls video"

RDEPEND=">=media-libs/mediastreamer-2.2.3_p1[video?]
	>=net-libs/libeXosip-3.0.2
	>=net-libs/libosip-3.0.0
	<net-libs/libosip-4
	<net-libs/libeXosip-4
	>=net-libs/ortp-0.15.0_p1
	gtk? ( dev-libs/glib:2
		>=gnome-base/libglade-2.4.0:2.0
		>=x11-libs/gtk+-2.4.0:2 )
	ncurses? ( sys-libs/readline
		sys-libs/ncurses )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/sgmltools-lite )
	nls? ( dev-util/intltool
		sys-devel/gettext )"

IUSE_LINGUAS="fr it de ja es pl cs nl sv pt_BR hu ru"

for l in ${IUSE_LINGUAS}; do
	IUSE="${IUSE} linguas_${l}"
done

# TODO:
# update ortp ?
# update mediastreamer ?

# TODO:
# run-time test for ipv6 : does it need mediastreamer[ipv6] ?

pkg_setup() {
	if ! use gtk && ! use ncurses; then
		ewarn "gtk and ncurses are disabled."
		ewarn "At least one of these use flags are needed to get a front-end."
		ewarn "Only liblinphone is going to be installed."
	fi

	strip-linguas ${IUSE_LINGUAS}

	if [[ -z "${LINGUAS}" ]]; then
		# no linguas set, using the default one
		LINGUAS=" "
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-external-mstreamer.patch

	# this patch removes need to gettext and intltool
	# but intltool was needed for eautoreconf so I add m4_pattern_allow
	# which is probably not the best way but it's working
	epatch "${FILESDIR}"/${PN}-3.1.0-nls.patch

	# remove speex check, avoid bug when mediastreamer[-speex]
	sed -i -e '/SPEEX/d' configure.in || die "patching configure.in failed"

	# fix path to use lib64
	sed -i -e "s:lib\(/liblinphone\):$(get_libdir)\1:" configure.in \
		|| die "patching configure.in failed"

	# removing bundled libs dir prevent them to be reconf
	rm -rf mediastreamer2 oRTP || die "should not die"
	# and references in Makefile.am
	sed -i -e "s:oRTP::" -e "s:mediastreamer2::" Makefile.am \
		|| die "patching Makefile.am failed"

	eautoreconf
}

src_configure() {
	# strict: we don't want -Werror
	# external-ortp,external-mediastreamer: prefer external libs
	# truespeech: seems not used, TODO: ask in ml
	# rsvp: breaking the build (not maintained anymore) --disable = --enable
	# alsa, artsc and portaudio are used for bundled mediastreamer
	econf \
		--libdir=/usr/$(get_libdir) \
		--disable-strict \
		--enable-external-ortp \
		--enable-external-mediastreamer \
		--disable-truespeech \
		--disable-dependency-tracking \
		$(use_enable doc manual) \
		$(use_enable gtk gtk_ui) \
		$(use_enable ipv6) \
		$(use_enable ncurses console_ui) \
		$(use_enable nls) \
		$(use_enable video)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS BUGS ChangeLog NEWS README README.arm TODO \
		|| die "dodoc failed"
}
