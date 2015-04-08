# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/makemkv/makemkv-1.8.10.ebuild,v 1.3 2014/10/15 20:44:34 pacho Exp $

EAPI=5
inherit eutils gnome2-utils multilib flag-o-matic

MY_P=makemkv-oss-${PV}
MY_PB=makemkv-bin-${PV}

DESCRIPTION="Tool for ripping Blu-Ray, HD-DVD and DVD discs and copying content to a Matroska container"
HOMEPAGE="http://www.makemkv.com/"
SRC_URI="http://www.makemkv.com/download/old/${MY_P}.tar.gz
	http://www.makemkv.com/download/old/${MY_PB}.tar.gz"

LICENSE="LGPL-2.1 MPL-1.1 MakeMKV-EULA openssl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="multilib"

QA_PREBUILT="opt/bin/makemkvcon opt/bin/mmdtsdec"

RDEPEND="
	sys-libs/glibc[multilib?]
	dev-libs/expat
	dev-libs/openssl:0
	sys-libs/zlib
	virtual/opengl
	dev-qt/qtcore:4
	dev-qt/qtdbus:4
	dev-qt/qtgui:4
	|| ( >=media-video/ffmpeg-1.0.0 >=media-video/libav-0.8.9 )
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/makemkv-oss-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.linux.patch
}

src_configure() {
	replace-flags -O* -Os
	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		econf
	fi
}

src_compile() {
	emake GCC="$(tc-getCC) ${CFLAGS} ${LDFLAGS}" || die "Make failed!"
}

src_install() {
	# install oss package
	dolib.so out/libdriveio.so.0
	dolib.so out/libmakemkv.so.1
	dolib.so out/libmmbd.so.0
	dosym libdriveio.so.0 /usr/$(get_libdir)/libdriveio.so.0.${PV}
	dosym libdriveio.so.0 /usr/$(get_libdir)/libdriveio.so
	dosym libmakemkv.so.1 /usr/$(get_libdir)/libmakemkv.so.1.${PV}
	dosym libmakemkv.so.1 /usr/$(get_libdir)/libmakemkv.so
	dosym libmmbd.so.0    /usr/$(get_libdir)/libmmbd.so
	dosym libmmbd.so.0    /usr/$(get_libdir)/libmmbd.so.0.${PV}
	into /opt
	dobin out/makemkv

	local res
	for res in 16 22 32 64 128; do
		newicon -s ${res} makemkvgui/share/icons/${res}x${res}/makemkv.png ${PN}.png
	done

	make_desktop_entry ${PN} MakeMKV ${PN} 'Qt;AudioVideo;Video'

	# install bin package
	pushd "${WORKDIR}"/${MY_PB}/bin >/dev/null
	if use x86; then
		dobin i386/{makemkvcon,mmdtsdec}
	elif use amd64; then
		dobin amd64/makemkvcon
		use multilib && dobin i386/mmdtsdec
	fi
	popd >/dev/null

	# install license and default profile
	pushd "${WORKDIR}"/${MY_PB}/src/share >/dev/null
	insinto /usr/share/MakeMKV
	doins *.{gz,xml}
	popd >/dev/null
}

pkg_preinst() {	gnome2_icon_savelist; }

pkg_postinst() {
	gnome2_icon_cache_update

	elog "While MakeMKV is in beta mode, upstream has provided a license"
	elog "to use if you do not want to purchase one."
	elog ""
	elog "See this forum thread for more information, including the key:"
	elog "http://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053"
	elog ""
	elog "Note that beta license may have an expiration date and you will"
	elog "need to check for newer licenses/releases. "
	elog ""
	elog "If this is a new install, remember to copy the default profile"
	elog "to the config directory:"
	elog "cp /usr/share/MakeMKV/default.mmcp.xml ~/.MakeMKV/"
}

pkg_postrm() { gnome2_icon_cache_update; }
