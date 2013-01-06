# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/x264-encoder/x264-encoder-0.0.20120707.ebuild,v 1.1 2012/07/08 17:11:26 lu_zero Exp $

EAPI=4

if [ "${PV#9999}" != "${PV}" ] ; then
	V_ECLASS="git-2"
else
	V_ECLASS="versionator"
fi

inherit flag-o-matic multilib toolchain-funcs ${V_ECLASS}

if [ "${PV#9999}" = "${PV}" ] ; then
	MY_P="x264-snapshot-$(get_version_component_range 3)-2245"
fi
DESCRIPTION="A free commandline encoder for X264/AVC streams"
HOMEPAGE="http://www.videolan.org/developers/x264.html"
if [ "${PV#9999}" != "${PV}" ] ; then
	EGIT_REPO_URI="git://git.videolan.org/x264.git"
	SRC_URI=""
else
	SRC_URI="http://download.videolan.org/pub/videolan/x264/snapshots/${MY_P}.tar.bz2"
fi

LICENSE="GPL-2"
SLOT="0"
if [ "${PV#9999}" != "${PV}" ] ; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
fi
IUSE="10bit custom-cflags debug ffmpeg ffmpegsource +interlaced mp4 +threads"

REQUIRED_USE="ffmpegsource? ( ffmpeg )"

RDEPEND="ffmpeg? ( virtual/ffmpeg )
	ffmpegsource? ( media-libs/ffmpegsource )
	mp4? ( >=media-video/gpac-0.4.1_pre20060122 )"

DEPEND="${RDEPEND}
	amd64? ( >=dev-lang/yasm-0.6.2 )
	x86? ( >=dev-lang/yasm-0.6.2 )
	x86-fbsd? ( >=dev-lang/yasm-0.6.2 )
	virtual/pkgconfig"

if [ "${PV#9999}" = "${PV}" ] ; then
	S=${WORKDIR}/${MY_P}
fi

src_configure() {
	tc-export CC

	local myconf=""
	use 10bit && myconf+=" --bit-depth=10"
	use debug && myconf+=" --enable-debug"
	use ffmpeg || myconf+=" --disable-lavf --disable-swscale"
	use ffmpegsource || myconf+=" --disable-ffms"
	use interlaced || myconf+=" --disable-interlaced"
	use mp4 || myconf+=" --disable-gpac"
	use threads || myconf+=" --disable-thread"

	# let upstream pick the optimization level by default
	use custom-cflags || filter-flags -O?

	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--disable-avs \
		--system-libx264 \
		--host="${CHOST}" \
		${myconf} || die

	# this is a nasty workaround for bug #376925 for x264 that also applies
	# here, needed because as upstream doesn't like us fiddling with their CFLAGS
	if use custom-cflags; then
		local cflags
		cflags="$(grep "^CFLAGS=" config.mak | sed 's/CFLAGS=//')"
		cflags="${cflags//$(get-flag O)/}"
		cflags="${cflags//-O? /$(get-flag O) }"
		cflags="${cflags//-g /}"
		sed -i "s:^CFLAGS=.*:CFLAGS=${cflags//:/\\:}:" config.mak
	fi
}
