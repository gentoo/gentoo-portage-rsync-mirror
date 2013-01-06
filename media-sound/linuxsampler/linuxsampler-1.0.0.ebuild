# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/linuxsampler/linuxsampler-1.0.0.ebuild,v 1.2 2012/05/05 08:33:38 mgorny Exp $

DESCRIPTION="LinuxSampler is a software audio sampler engine with professional grade features."
HOMEPAGE="http://www.linuxsampler.org/"
SRC_URI="http://download.linuxsampler.org/packages/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc jack sqlite"

RDEPEND="sqlite? ( >=dev-db/sqlite-3.3 )
	>=media-libs/libgig-3.3.0
	media-libs/alsa-lib
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_compile() {
	econf --enable-alsa-driver \
		--disable-arts-driver \
		$(use_enable jack jack-driver) \
		$(use_enable sqlite instruments-db)
	emake || die "emake failed."

	if use doc; then
		emake docs || die "emake docs failed."
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README

	if use doc; then
		dohtml -r doc/html/*
	fi
}
