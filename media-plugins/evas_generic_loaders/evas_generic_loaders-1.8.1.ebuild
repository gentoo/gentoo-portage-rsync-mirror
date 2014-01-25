# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/evas_generic_loaders/evas_generic_loaders-1.8.1.ebuild,v 1.1 2014/01/25 16:27:49 tommy Exp $

EAPI=3

inherit enlightenment

MY_P=${PN}-${PV/_/-}

DESCRIPTION="Provides external applications as generic loaders for Evas"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="http://download.enlightenment.org/rel/libs/${PN}/${MY_P}.tar.bz2"

LOCENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer pdf postscript raw svg"

S=${WORKDIR}/${MY_P}

RDEPEND="
	>=dev-libs/efl-1.8.0_beta2
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
