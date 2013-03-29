# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/noad/noad-0.7.3-r1.ebuild,v 1.1 2013/03/29 09:41:14 ssuominen Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Mark commercial Breaks in VDR records"
HOMEPAGE="http://noad.heliohost.org/"
SRC_URI="http://noad.heliohost.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg imagemagick"

DEPEND="media-libs/libmpeg2:=
	ffmpeg? ( virtual/ffmpeg )
	imagemagick? ( media-gfx/imagemagick:= )
	!media-plugins/vdr-markad"
RDEPEND="${DEPEND}"

src_prepare() {
	EPATCH_FORCE=yes EPATCH_SUFFIX=diff EPATCH_SOURCE="${FILESDIR}"/patches-${PV%.*}.x epatch

	if has_version '>=media-video/vdr-1.7.15'; then
		sed -i -e 's:2001:6419:' -i svdrpc.cpp || die
	fi

	sed -i -e '/CXXFLAGS.*O3/d' configure.ac || die #426746

	# FIXME: --with-tools, markpics will compile but showindex won't!
	sed -i \
		-e '/^noinst_PROGRAMS/s:@TOOLSRC@::' \
		-e '/^EXTRA_PROGRAMS/s:showindex::' \
		Makefile.am || die

	eautoreconf
}

src_configure() {
	econf \
		$(use_with imagemagick magick) \
		--with-mpeginclude=/usr/include/mpeg2dec \
		--with-tools \
		$(usex ffmpeg '--with-ffmpeg --with-ffmpeginclude=/usr/include' '')
}

src_install() {
	dobin noad # showindex
	use imagemagick && dobin markpics

	dodoc README INSTALL
	# example scripts are installed as dokumentation
	dodoc allnewnoad allnoad allnoadnice clearlogos noadifnew stat2html

	newconfd "${FILESDIR}"/confd_vdraddon.noad vdraddon.noad

	insinto /usr/share/vdr/record
	doins "${FILESDIR}"/record-50-noad.sh

	insinto /usr/share/vdr/shutdown
	doins "${FILESDIR}"/pre-shutdown-15-noad.sh

	insinto /etc/vdr/reccmds
	doins "${FILESDIR}"/reccmds.noad.conf

	exeinto /usr/share/vdr/bin
	doexe "${FILESDIR}"/noad-reccmd
}

pkg_postinst() {
	elog
	elog "To integrate noad in VDR you should do this:"
	elog
	elog "start and set Parameter in /etc/conf.d/vdraddon.noad"
	elog
	elog "Note: You can use here all pararmeters for noad,"
	elog "please look in the documentation of noad."
}
