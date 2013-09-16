# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/handbrake/handbrake-9999.ebuild,v 1.13 2013/09/16 12:42:28 tomwij Exp $

EAPI="5"

PYTHON_COMPAT=( python2_{6,7} )

inherit autotools eutils gnome2-utils python-any-r1

# TODO: Are KEYWORDS like these stabilization script friendly?
#       We can opt to move the KEYWORDS from the else before the if;
#       that way, it is listed first and the 9999 version will set it to "".
if [[ ${PV} = *9999* ]]; then
	ESVN_REPO_URI="svn://svn.handbrake.fr/HandBrake/trunk"
	inherit subversion
	KEYWORDS=""
else
	SRC_URI="http://handbrake.fr/rotation.php?file=HandBrake-${PV}.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/HandBrake-${PV}"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Open-source, GPL-licensed, multiplatform, multithreaded video transcoder."
HOMEPAGE="http://handbrake.fr/"
LICENSE="GPL-2"

SLOT="0"
IUSE="fdk ffmpeg gstreamer gtk"

# Use either ffmpeg or gst-plugins/mpeg2dec for decoding MPEG-2.
REQUIRED_USE="!ffmpeg? ( gstreamer )"

# TODO: As we improve src_configure with more flags we can make more optional here.
#       Besides that, we should list slots for all the dependencies as well as
#       support sub slot rebuilds where they are still missing; lets avoid running
#       into more problems while we can.
RDEPEND="
	media-libs/a52dec
	media-libs/faac
	media-libs/libass
	media-libs/libbluray
	media-libs/libdvdnav
	media-libs/libdvdread
	media-libs/libmpeg2
	media-libs/libmp4v2:0
	media-libs/libmkv
	media-libs/libsamplerate
	media-libs/libtheora
	media-libs/libvorbis
	media-libs/x264:=
	media-sound/lame
	ffmpeg? ( || ( >=media-video/libav-9:= >=media-video/ffmpeg-1.2.1:0= ) )
	sys-libs/zlib
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		!ffmpeg? ( media-plugins/gst-plugins-mpeg2dec:1.0 )
	)
	gtk? (
		x11-libs/gtk+:3
		dev-libs/dbus-glib
		dev-libs/glib:2
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/libnotify
		x11-libs/pango
		>=virtual/udev-171[gudev]
	)
	fdk? ( media-libs/fdk-aac )
	"

DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	dev-lang/yasm
	dev-util/intltool
	sys-devel/automake"

pkg_setup() {
	python-any-r1_pkg_setup
}

src_prepare() {
	# Get rid of leftover bundled library build definitions,
	# the version 0.9.9 supports the use of system libraries.
	# TODO: Is this still needed, does this sed still do something?
	#       If it does; we should convert this into a patch, such that we know it fails.
	sed -i 's:.*\(/contrib\|contrib/\).*::g' \
		"${S}"/make/include/main.defs \
		|| die "Contrib removal failed."

	# Instead of adding a #define to libmkv, we expand it in place. 
	epatch "${FILESDIR}"/${PN}-9999-expand-MK_SUBTITLE_PGS.patch

	# Fix compilation against the released 1.9.1 version of mp4v2.
	epatch "${FILESDIR}"/${PN}-9999-fix-compilation-with-mp4v2-v1.9.1.patch

	# Remove libdvdnav duplication and call it on the original instead.
	# It may work this way; if not, we should try to mimic the duplication.
	epatch "${FILESDIR}"/${PN}-9999-remove-dvdnav-dup.patch

	# Remove faac dependency until its compilation errors can be resolved.
	# TODO: If --disable-faac works then this patch can be removed;
	#       we also need to figure out if this is still needed, maybe things are patched.
	epatch "${FILESDIR}"/${PN}-9999-remove-faac-dependency.patch

	# Make use of an older version of libmkv.
	epatch "${FILESDIR}"/${PN}-9999-use-older-libmkv.patch

	# Make use of an unpatched version of a52 that does not make a private field public.
	epatch "${FILESDIR}"/${PN}-9999-use-unpatched-a52.patch

	# Add gmodule to the linker command line for bug #482674.
	epatch "${FILESDIR}"/${PN}-0.9.9-add-gmodule-to-gtk-configure.patch

	# Fixup configure.ac with newer automake.
	# TODO: Would like to see this shorten towards the future;
	#       see which are still needed, put those in a patch instead of 6 lines here.
	cd "${S}/gtk"
	sed -i \
		-e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:g' \
		-e 's:AM_PROG_CC_STDC:AC_PROG_CC:g' \
		-e 's:am_cv_prog_cc_stdc:ac_cv_prog_cc_stdc:g' \
		configure.ac || die "Fixing up configure.ac failed"

	# Don't run autogen.sh.
	# TODO: Document why we're not running this.
	sed -i '/autogen.sh/d' module.rules || die "Removing autogen.sh call failed"

	eautoreconf
}

src_configure() {
	# TODO: Try to make parameters avformat, libav-aac, libmkv, mp4v2 optional
	#       as for making faac optional, see the above TODO first.
	#
	#       Just to be sure, check the ./configure --help before each release;
	#       they are still in the progress of unbundling / making things optional.
	#
	#       Check if the Python-ish implementation supports econf style.
	./configure \
		--force \
		--prefix="${EPREFIX}/usr" \
		--disable-gtk-update-checks \
		--disable-faac \
		--enable-avformat \
		--disable-libav-aac \
		--enable-libmkv \
		--enable-mp4v2 \
		$(use_enable fdk fdk-aac) \
		$(use_enable ffmpeg ff-mpeg2) \
		$(use_enable gtk) \
		$(usex !gstreamer --disable-gst) || die "Configure failed."
}

src_compile() {
	emake -C build

	# TODO: Documentation building is currently broken, try to fix it.
	#
	# if use doc ; then
	# 	emake -C build doc
	# fi
}

src_install() {
	emake -C build DESTDIR="${D}" install

	dodoc AUTHORS CREDITS NEWS THANKS TRANSLATIONS
}

pkg_postinst() {
	einfo "For the CLI version of HandBrake, you can use \`HandBrakeCLI\`."

	if use gtk ; then
		einfo ""
		einfo "For the GTK+ version of HandBrake, you can run \`ghb\`."
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
