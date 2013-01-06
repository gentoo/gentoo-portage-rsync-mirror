# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/evas_generic_loaders/evas_generic_loaders-1.7.4.ebuild,v 1.1 2012/12/21 21:04:15 tommy Exp $

EAPI=2

inherit enlightenment

DESCRIPTION="Provides external applications as generic loaders for Evas"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

LOCENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer pdf postscript raw svg"

RDEPEND="
	>=media-libs/evas-1.7.0
	gstreamer? ( media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10 )
	pdf? ( app-text/poppler )
	postscript? ( app-text/libspectre )
	raw? ( media-libs/libraw )
	svg? ( gnome-base/librsvg
		x11-libs/cairo )"
DEPEND="${RDEPEND}"

src_configure() {
	local MY_ECONF="$(use_enable gstreamer)
		$(use_enable pdf poppler)
		$(use_enable postscript spectre)
		$(use_enable raw libraw)
		$(use_enable svg)"

	enlightenment_src_configure
}
